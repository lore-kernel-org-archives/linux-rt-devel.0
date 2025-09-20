Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761811FF61E
	for <linux-rt-devel@lists.linux.dev>; Sat, 20 Sep 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758384044; cv=none; b=K6DmEXpP/r7tPYe+Or5kRlBku6kL8Clm53njiOu1eZH/ul7DZtOoikFphalMBCdTtc0f9rmehnZOqrjSE6yAANt+uEriEaM8k1WbSwtctoq5+siu5iRAkEWXJLDgEqBOka07Abse+Fi0Pp5TW4q1Msz1lyrzHUkWvU9KSI8YLiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758384044; c=relaxed/simple;
	bh=0FXSiX8LV1vGBvynLmEYz4qPHdBcTqMHOixN5CzoCzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQ3FT0V8MmtTLQZEmT+ZNpcrVnmhQdKdtrH99C7ft3FnYhX3zOcN+6Dt4+8D5n+WJujKkcg/AOj2PZY021LjT9b6r21E58PomhuWw+oG6T4Ke/6HSh4/OE1mdfiVCEvUi6+wxtX2iAAqbUHW1wGKBp59KFUukyNgNQiTDmqR5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bMQICGNT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bMQICGNT"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fc14af3fbso3728958a12.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 20 Sep 2025 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758384039; x=1758988839; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6bGBwhqJX9F0xOuCnvuuNe/MoHdsR7Bf1qZLNoNX5Qk=;
        b=bMQICGNTQnbsOqAs9U+0fCOpUes3wS5Evi6u5q8+x4oMQXoKMbOzBwgx1p8kHL9rto
         ivZKHoS3PgjLJULhP6v7BaN7E3+M9rXaLMAfqlt5/5D3i1eoh0HUsid2WCLNYG6mGsZV
         p0hiZvBiGUj4rdwfLopeIn95ERDy3DDVlhEZvP7RmZK+NqUjW47DzZhwvb43jUrQp3+2
         8/DFFzDRx3Sk6A8h79qEHx+YTFQ8SGKMjzlalO0EhsbxLwQJjNFkw528Z3tTgHjPGIYf
         RLeh0blUN80xXKFOR2namkkR5wuO423Sp/SZblU9vMk/H8f1J/Xt7fkJGRVL06L9vL0X
         WoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758384039; x=1758988839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bGBwhqJX9F0xOuCnvuuNe/MoHdsR7Bf1qZLNoNX5Qk=;
        b=tOcr5ADK69krydz36XPZZxKknjvv40q2mIjqOn0+gQLg6BHMPHxULa6ERq4Dsw9CVb
         D2UPtQ4HJFf5phQLo0Tt/4yg5Of+QRWAyOiLgOLGMKHyojwyAHwvatSPEtS7TOswVp74
         Xw0zBua+89s0lKLSFp7UMNAN+rumcDgZ6TnhNWVlW5yiH2o/ZLCbbyPPg+miP9y+ox1j
         ptFePHjx+ZfdxhTI03Li63qCpbfP/X9Wu58vmhrgLImFtK/7gJZfRPI1nLNmDS4Gzw8w
         63UjI4h1vTETBBvzAdeHNzGb+QDhvh6F9aoNkmtBo/43QdGU1zknR7xTJPsUhnkLyn/b
         EPlA==
X-Forwarded-Encrypted: i=1; AJvYcCWToP9U1uTK/IXSlSX+TxtDt7nauRxffE7KGuXxcyXU5OvRSOgnqxr6IHfFQUEgeSeFF1AOvhGidb/kw7n+Hw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4zpc22k8e4t2EskK9jedrMYqWqsWI8u73LJHXAkARbR3jFAth
	KR5Cc+fTCHBYiXN8zJURfJ06DwexqDwnt604hJCvhAb3SXzFB39zbjy2dtOGTfibxdn7pqrbyvu
	KZSBgAVxbmthVoq9uEh6hpReQQJM42X+Xxe0dzYm23w==
X-Gm-Gg: ASbGncugKq3BYu6lPspEBOuJW2heBqpOu78Y6sKhObS5O1K3lC1USTmMAZKZV6E4mIe
	glDloCYB9rGQTuPxvcAEIa4mnvqvZAs8POaSh4sL9U45D/ZMM3s2KIGfm17+c+90Qyw2g8oej9K
	cvC+T1W2XKc6Q5WM0VdvmtR0Nwu7fkqF44bu6BwsBX31mttM9l4eZuKW9nwWiXzyEB7RXoKYaTS
	p69bRqZ1XhPnlPRq2FEJVlbFvGbM7GmxPsQ
X-Google-Smtp-Source: AGHT+IGhUL+kILCgvIy42z2qBJz3nD98fFtf16ENDJwDcWGqNqZPLpWOf/WplU4dCmobMVHp3dmQfvBSGbyb8aaZ16k=
X-Received: by 2002:a05:6402:208a:b0:62f:31f6:6aac with SMTP id
 4fb4d7f45d1cf-62fc0a7b1e0mr6728772a12.23.1758384038519; Sat, 20 Sep 2025
 09:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKfTPtBp85jaM8sdOXqB1Fq7XcfgGP-T2A=fd4Qbhe48CUNUGA@mail.gmail.com>
In-Reply-To: <CAKfTPtBp85jaM8sdOXqB1Fq7XcfgGP-T2A=fd4Qbhe48CUNUGA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sat, 20 Sep 2025 18:00:26 +0200
X-Gm-Features: AS18NWCZwxYmt0CLn-uDv8qhYWdHHmD_8uweCDgoyxFrcUPIiuRHE3oZNODkeAQ
Message-ID: <CAKfTPtBKB41LyyfSDm7RK=gbDt3JjY_k8SJAALxQzxGACEp+ig@mail.gmail.com>
Subject: Re: Call for Speakers: Join us at the Scheduler and Real-Time
 Microconference at LPC2025!
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <williams@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	John Stultz <jstultz@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Phil Auld <pauld@redhat.com>, dhaval@gianis.ca, Aaron Lu <ziqianlu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Just a friendly reminder that the Call for Proposals for the Scheduler
and Real-Time Microconference at Linux Plumbers 2025 closes on Sept
30th, 2025.

We're looking forward to receiving your proposals!

Best regards,
The Scheduler and Real-Time Microconference Team
- Dhaval Giani <dhaval.giani@gmail.com>
- Juri Lelli <juri.lelli@redhat.com>
- Phil Auld <pauld@redhat.com>
- Steven Rostedt <rostedt@goodmis.org>
- Vincent Guittot <vincent.guittot@linaro.org>

On Mon, 18 Aug 2025 at 20:31, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Hello everyone,
>
> We're pleased to announce that the Call for Topics for the upcoming
> Scheduler and Real-Time Microconference at Linux Plumbers 2025, is
> open!
>
>     https://lpc.events/event/19/sessions/218/
>
> This event is designed to gather kernel developers and engineers to
> share knowledge on scheduler and/or real time issues in Linux and
> connect with peers. This year, we are joining the tightly linked
> Real-Time and scheduler topics in one same microconference.
>
> We're particularly interested in talks that:
>
>     - Spark Discussion: The goal is to discuss open problems,
> preferably with patch sets already on the mailing list.
>
>     - Are Concise: Presentations are meant to be limited to 2 or 3
> slides intended to seed a discussion and debate.
>
> Some possible topics for discussions:
>
>     - Improve responsiveness of fair tasks
>     - Improve PREEMPT_RT
>     - Improve Locking and priority inversion
>     - Impact of new topology, including hybrid or heterogeneous system
>     - Improvements on SCHED_DEADLINE and DL server
>     - Tooling for debugging low latency analysis
>
> It is also perfectly fine if you have a new topic that is not on the
> list above. People are encouraged to submit any topic related to
> real-time and/or scheduling.
>
> Ready to submit? Please fill out the submission form by
>
>     Sept 30th 2025
>
> at this link:
>
>     https://lpc.events/event/19/abstracts/
>
> and select
>
>     "Scheduler and Real-Time MC" as the track.
>
> We can't wait to see your proposal and build a fantastic lineup together.
>
> If you have any questions, don't hesitate to reach out.
>
> Best regards,
>
> The Scheduler and Real-Time Microconference Team
> - Dhaval Giani <dhaval.giani@gmail.com>
> - Juri Lelli <juri.lelli@redhat.com>
> - Phil Auld <pauld@redhat.com>
> - Steven Rostedt <rostedt@goodmis.org>
> - Vincent Guittot <vincent.guittot@linaro.org>
