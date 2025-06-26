Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A817BA5
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Jun 2025 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750937863; cv=none; b=Tzd0wQpJAOxZAQ03GL0SXPkUwEeePIR6WuXTU/SR2rZLt++3TgevlhBLgMHXcA68QqpttO4NMehxBAHJa9i0+QHlqbhvfF/mm8YWvAvK2SbHKdHweyE3szIL6rCkZn3ZmSwxO2DkWfh/A+IkiVWk3xLLClCWr0XkX1UOjX2MDJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750937863; c=relaxed/simple;
	bh=oijaoHUkd+q65l+4bZDfbmpmn8jmxpyjZB+m3EReZ5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AP4W4xz9p1u29I4grGLpiWuPGAfF5RIfiempffA71CaQh0jz/Fpz7vdk5a67U0Fljlfp3U2K+AZ2q4RfZgFRDCWaB0NUUufRqeYvt1ycHnYVdIWdHqJ52AnpSidEG1bSGdWXUABWI6jZe427DN15xLvVQrb6vDiOobUaLnQ85ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yydu/JQS; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yydu/JQS"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71173646662so9666007b3.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 26 Jun 2025 04:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750937861; x=1751542661; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7T/PFAjUgAbCxF3fTY06Ptb9oq5X+RNiebYjCU0JVhA=;
        b=Yydu/JQSzcuuQ4QpU8F9xY16ocsvD+3ICxncYbD5rHlOuiNT74UdML7jWPLr8A8OyP
         /VAVYFdfxrYtyIGx7798dbDn6u0SRxgY4aAaHOZRYL1REWOd0QJO3ENEphpWVWgj9B9K
         4kb4kOIA8sL9Snosy1iWrwOA3P4ALdweoVwLJqFoZB//rJb70EHhGCpdNT0PoWaMq95y
         5ejo/AuzdtwvxnhOx8CzJjiXljGmOwFCj0Jrob5+0cEeYJwhYHGj3ReNl9iQjAjLi1bW
         rkGNtctCIEoFPUJNlmy08GvWOKZj4ymKNnU/NRTWxCE/EdweWE0GEYYgVeASRVYSJ+DY
         nvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750937861; x=1751542661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7T/PFAjUgAbCxF3fTY06Ptb9oq5X+RNiebYjCU0JVhA=;
        b=sZsxbMOqdASslBK9umCI6ZMHKFJhiZ1FNkXyojw2nuCfVKFHX4WKiV2OpMvndh4gDt
         BdPQsE2nt70EMfbnCycUzBi/Q+Rvk6jTfsBniLUTp1JA1OXLJGYPHfLq8nQvQ3flSQJI
         T9mZPxi35mBdduEwuDXnmePETEpKBpKzQadwp6wOSLADZ21+UasTiYmIv7dVulNWYQmz
         pfA0h+Etxgm4J7coh4+bvPPfn2MouK9DUyFV1iRVPd7AwFUGXk3K/5G61uftXT2E8Mtb
         RlgNKNApywbMjLy8bOVB+kCVL7xFtwpS8K/XIqsBPEeSLneTLXF84tespjUtcRFUdfrB
         76VQ==
X-Gm-Message-State: AOJu0YxZ3ZzCtXY51zpnxx+RhJyP7LCH5TMGVLwWPx9+wKpcrWpmyGNk
	EloRzYcnKrFAkDbUHfYz7bDqWbTGRITLNuQmL0EZEuy9qOwkMq7wDXtryu+49050loLP6VKGz9q
	jtewhj3Mzjay5t5+izCj1y240uD23fvs=
X-Gm-Gg: ASbGncsNuK7QMB0903tXWQLTpDF9dVH5w4ooHIashkVeKI0f9Q1PYpqBAYdPss3Cpr3
	ouQQz8azsZHLZ1teOQNnm+nCuKT+u7Xh9TBJWLN4jog5PARQ/qpmxx7KMARSPWLk3p2CMnFgcMi
	Tj8RLnBZkF7md3st3kW3CAmjIlj8RIeUvn2ajB2LAtc7Tr
X-Google-Smtp-Source: AGHT+IGSZDXv0Fl9Sek1EYQSuTiEx7VI2AW6SAi74hyC1Xulp+Lhx9xstmR17Xwr9KXQibdpQNeO1ZidQsrGeFNUWwU=
X-Received: by 2002:a05:690c:4d82:b0:70e:2ba2:659d with SMTP id
 00721157ae682-71406da0ba0mr100064607b3.23.1750937860762; Thu, 26 Jun 2025
 04:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAMeyCbgeL-UuxiJPVy_=zLSJfWgudKAvSQVViL8=u05yty_Pyg@mail.gmail.com>
 <20250623143051.pCoclIs7@linutronix.de>
In-Reply-To: <20250623143051.pCoclIs7@linutronix.de>
From: Kegl Rohit <keglrohit@gmail.com>
Date: Thu, 26 Jun 2025 13:37:29 +0200
X-Gm-Features: Ac12FXyQuRLhBAOR7eQuicKCFs8zGf-yXTdaItkBStI0RJXAlC06SGIi-e_HwHk
Message-ID: <CAMeyCbgB=iBVhePLKbUoyhcpE+E7oJjFYuK+dvFCjn8cXLK4SA@mail.gmail.com>
Subject: Re: ksoftirqd priority inversion wait_event_interruptible_timeout/schedule_timeout/del_timer_sync
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thanks for your answer.
yes, I am aware of the ktimer thread split. In some kernel versions it
is split in and in some not.
In 5.10-rt the timers use ksoftirqd. Does a ktimer split backport
exist? Or do you think a backport would be more harmful than helpful?

On Mon, Jun 23, 2025 at 4:30=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-06-17 09:52:07 [+0200], Kegl Rohit wrote:
> > Hello!
> Hi,
>
> > Using 5.10.184-rt90 on arm (nxp imx6q).
> >
> > A proprietary driver starts a `kthread` with `SCHED_FIFO` -98 priority.
> > This `kthread` waits for a completion using
> > `wait_event_interruptible_timeout(comp, 1000)`
> > and wakes up every second to perform its work. The completion itself
> > only fires very infrequently.
> >
> > Tracing the kernel showed that `ksoftirqd` was periodically boosted to
> > the same `SCHED_FIFO` -98 priority.
> > This is caused by the `schedule_timeout` handler within
> > `wait_event_interruptible_timeout`.
> >
> > del_timer_wait_running takes spin_lock_bh and causes the priority inver=
sion.
> > This is very bad because e.g. network softirq processing happens with
> > very high priority for some time.
> >
> > Was this issue addressed in a more recent kernel version?
>
> The timer related bits moved to ktimersd thread (instead of ksoftirqd)
> but the basic boosting problem remains.
>
> There is work in progress to address this. The endgame is:
>         https://lore.kernel.org/linux-rt-devel/20250613105653.1860729-1-b=
igeasy@linutronix.de/
>
> Sebastian
