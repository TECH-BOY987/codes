const startButton=document.getElementById('start-btn')
const nextButton=document.getElementById('next-btn')

const questionContainerElement=document.getElementById("question-container")
const questionElement=document.getElementById('question')
const answerButtonElement=document.getElementById('answer-buttons')

let shuffleQuestions,currentQuestionIndex;
let quizScore=0;

const questions=[
    {
        question:'Choose your a letter comes before "s"',
        answers:[
            {text:''}
        ]
    }
]