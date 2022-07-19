package main

import (
	"fmt"
	"math"
	"os"
	"strconv"

	"encoding/json"
	"io/ioutil"
	"net/http"

	env "github.com/caitlinelfring/go-env-default"
	"github.com/gin-gonic/gin"
	"go.elastic.co/apm/module/apmgin/v2"
)

type Person struct {
	Name   string  `json: "name"`
	Height float64 `json: "height"`
	Weight float64 `json: "weight"`
	BMI    float64 `json: "bmi"`
	Label  string  `json: "label"`
}

var persons = []Person{}
var file string = "data.json"

func readData(data string) {

	fget, _ := ioutil.ReadFile(data)
	_ = json.Unmarshal([]byte(fget), &persons)

}

func writeData(data string) {

	fwrite, _ := json.MarshalIndent(persons, "", " ")
	_ = ioutil.WriteFile(data, fwrite, 0644)

}

func (p *Person) bmiCalculation() float64 {

	p.BMI = math.Round(p.Weight/(p.Height*p.Height)*100000) / 10
	return p.BMI

}

func (p *Person) defineLabel() string {

	switch {
	case p.BMI < 18.5:
		p.Label = "Underweight"
	case p.BMI > 18.5 && p.BMI < 24.9:
		p.Label = "Normal Weight"
	case p.BMI > 25 && p.BMI < 29.9:
		p.Label = "Overweight"
	case p.BMI > 30:
		p.Label = "Obesity"
	default:
		p.Label = "Undefined"
	}

	return p.Label

}

func homePage(c *gin.Context) {

	var newPerson Person
	p := &newPerson

	p.Weight, _ = strconv.ParseFloat(c.Query("weight"), 64)
	p.Height, _ = strconv.ParseFloat(c.Query("height"), 64)

	if p.Height == 0 || p.Weight == 0 {
		c.String(http.StatusOK, "Please insert Weight and Height Query! %s",
			os.ExpandEnv("\nExample: http://localhost:${PORT}/?height=167&weight=70"))
		return
	}

	p.bmiCalculation()
	p.defineLabel()
	c.String(http.StatusOK, "Your BMI is: %.1f \nYour Label is: %s", p.BMI, p.Label)

}

func listPersons(c *gin.Context) {

	readData(file)
	c.IndentedJSON(http.StatusOK, persons)

}

func postPerson(c *gin.Context) {

	var newPerson Person
	p := &newPerson

	if err := c.BindJSON(&newPerson); err != nil {
		return
	}

	readData(file)
	p.bmiCalculation()
	p.defineLabel()

	persons = append(persons, newPerson)

	writeData(file)
	c.IndentedJSON(http.StatusCreated, newPerson)

}

func main() {

	PORT := env.GetDefault("PORT", "8000")
	fmt.Println(os.ExpandEnv("PORT: ${PORT}"))

	app := gin.New()
	app.Use(apmgin.Middleware(app))

	app.GET("/", homePage)
	app.GET("/list-persons", listPersons)
	app.POST("/calculate-bmi", postPerson)
	app.Run(os.ExpandEnv("0.0.0.0:" + PORT))

}
