import React, { useState, useEffect } from 'react';
import axios from 'axios';

interface IEvent {
    _id: string;
    date: Date;
    events: [{ date: Date; value: string; }]
}
// Create your functional component:
export const Events: React.FC = () => {
    const [events, setEvents] = useState<IEvent[]>([]);

    useEffect(() => {
        getEvents()
    }, []);

    const getEvents = () => {
        return axios.get(`/events`).then(res => {
            console.log(res.data)
            setEvents(res.data)
        })
    }
    const createEvent = () => {
        axios.post(`/events`)
            .then(_ => getEvents())
    }

    return (
        <main>
            <button onClick={createEvent}>Create events</button>
            <h3>Events from server: </h3>
            <ul>
                {events?.map(item => <li>{item.events[0].date}</li>)}
            </ul>
        </main>
    );
}