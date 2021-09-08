import {Request, Response} from "express";

import bodyParser from "body-parser";
import express from "express";
const app = express()

app.use(bodyParser.json())

app.all('/emojis', (req: Request, res: Response) => {
  res.json({ data: 'data' })
})

export default app
