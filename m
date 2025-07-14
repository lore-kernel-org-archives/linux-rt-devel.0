Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8D425EFBC
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Jul 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509839; cv=none; b=cK7AD1+8P4bVCH4Ro2DkYnAtdLrzquQ9szJj5zi2NihAVMI0W3NNM8ZxPntP/DmSz3aTPZ6AfAElWdfl506SId6Qu9IcPtfq6eGPl7gCGmqkqstoJrIXhVgzSQW4rBB6fEBox6Ns0exQ+c1WOBSxE/LSdAKY1jdRkSIYONinKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509839; c=relaxed/simple;
	bh=i/R26POJP4dDcBivK5gMdeMHp+1pQls5mGnd176yHgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAP+vCdxdb4M7GaWkq8rDoNGSrfglLQhuXtspDaQpGsZwFo2bIqa66IQFyw0fC8NmqhOmBq92yErzL9H2K6u0dWU3Cp9uAvKqhXXc+HqbOJd1Zc1T/YlBcc6r9d93dp6MahLNOWdB16OEDGUKwOW61y3FOWc62JKgSVZQEVYBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NSXQuLrS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NSXQuLrS"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso8822648a12.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 14 Jul 2025 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752509836; x=1753114636; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nEQq66OWWE9JtkTfXjKqpWkex8XQYQ6HwopNDNvjlsc=;
        b=NSXQuLrSa3XZRgxUjI8NXRS2kcdNmmkgadvUxWXl7PT4KsbCL7MCKxl6ZKI+gx7Zej
         Pk5kPi4guqk+Jach0lE1LkRhsvwyQ5nzXWAopb6MjQ7bcp0bivTqe5Q+BcdjlCDBTZ5n
         qp3Ic9hlaAk47+Gu8J+y4kpOOhsSshv0/K2qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509836; x=1753114636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEQq66OWWE9JtkTfXjKqpWkex8XQYQ6HwopNDNvjlsc=;
        b=QoVOFeEhw11Tr+xAfDYeCi90q040vyM5RtVxXI3Iu5pdpwG4/n57Ru3ozna7q7F0x+
         ooPTPZg+JZwuw3pbkmi9OkmTvyT0OAhBZfotKIuAUds05rwej3pgxsuliX40s7zXjVlb
         Bm7BLioWqZlYaTl0OEm+zBW2rM3cYLidFrf+YJu/dbhEJpYsAX7Q2MPmnBzrSvnAWzFY
         n3p++4wY+3Z9LXX1mH6m3wH0Vag7d9Y5PUuWgVrmvfPUks5xnYnoyb/kbqbtm+nVLRLE
         Fzvo92xkOw1oddgccUKobBWQfRIiGgnqOn2zu3xdLL7KJ4OgGwSHd85sDe2AQrTLCVmm
         MgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW/2CADzghPv6yldc5diKxGo/6VPqWFrPfUhzG+8Nd2StnwUSegxlPnfe9kRebHt6/T31+aTg35J67Plhxgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTxRlBN7ZHvnz5QVF3Z4Lm2anAG5IbskkXRQmLstR1GD5PJjFt
	6m9f5RgqDRBfZjJAJqao6jwhRrcnoEhDzCo9w8wGQklpOhuER8B9lvz1QTcBxPnOzet7xudWyqV
	apkhUfug=
X-Gm-Gg: ASbGnctOqTSO/bzcTdIxH1J310MJjIb3jBZkjkPVjy0qRNw2dyM2DtjduiN5u1eCWJp
	9CPy/mRucdg1nvV9bBHijEVKc/KNDE/gXJ9RjgvlxB/gr6LaVzD33E18p9v8k90nMQ7wvaSt2lg
	zNqSgdQePLkBM+49avvU+z8aX10i17ovabuNOZkootF0vtDWLYx6zLzn2jDohrnfQH0kjQjwReP
	cD2QYuFrSy5oVrcbEIc+UI7jrgeYkCjxBK0VIvXGDQmDGWqu2tWDahE9oKL9Bd+0XwUxybpvyLZ
	U5vdsnfZSrtn4TTXdY5ugtFDKYxjahhUFaz75vJ49kQlugrHeL2RcXl31PisPbclL7BkDiHpzne
	WmKYqpzSBMvtZCDjXjNbeq2Fxodxsdi646zo4qyU20y0apjarEv6shoHTK3PScY7Io3BAJBA6XM
	QQ5mYw8Ng=
X-Google-Smtp-Source: AGHT+IEOFfJQMKLooyO0F+QLTQyfmi5P+5TW1g2XL6MIilDzyYzoR16XO+Z2SdAEr727VlKlDeq59w==
X-Received: by 2002:a05:6402:2401:b0:602:bfc6:f99d with SMTP id 4fb4d7f45d1cf-611e84c1a9cmr13483540a12.24.1752509835619;
        Mon, 14 Jul 2025 09:17:15 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9733e9fsm6241705a12.52.2025.07.14.09.17.13
        for <linux-rt-devel@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 09:17:14 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso8822573a12.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 14 Jul 2025 09:17:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAVG8pdysIII+yt4E34qBwWrlskO8l1sO0YbHlP1b9cpJO2IuJpr2ACyryhu7UQnV/UBSSwE7nONvRXzjmIg==@lists.linux.dev
X-Received: by 2002:aa7:d78f:0:b0:602:201:b46e with SMTP id
 4fb4d7f45d1cf-611e84f8dd6mr9695286a12.31.1752509833354; Mon, 14 Jul 2025
 09:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250710034805.4FtG7AHC@linutronix.de> <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de> <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de> <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de> <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <20250711095008.lBxtWQh6@linutronix.de> <20250714-leumund-sinnen-44309048c53d@brauner>
In-Reply-To: <20250714-leumund-sinnen-44309048c53d@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Jul 2025 09:16:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whniDdvSeCEQD5aUzr79HnhZ=A+ftzr0p_mY+n_f0AMHg@mail.gmail.com>
X-Gm-Features: Ac12FXxWB0yp1KMBo5BvpABIxBDtYWLONaWyJRXqnq_-Wkoa7_1NLpHwfbQeSac
Message-ID: <CAHk-=whniDdvSeCEQD5aUzr79HnhZ=A+ftzr0p_mY+n_f0AMHg@mail.gmail.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
To: Christian Brauner <brauner@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, 
	Joe Damato <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 02:00, Christian Brauner <brauner@kernel.org> wrote:
>
> I was on the fence myself and I juggled the commit between vfs.fixes and
> vfs-6.17.misc because I wasn't sure whether we should consider such
> priority inversion fix something that's urgent or not.

Well, this time it actually helped that it didn't come in through the
merge window, because it made the bisection much shorter.

But in general, I do think that eventpoll should be considered to be
something that needs to die, rather than something that needs to be
improved upon. It's horrendous.

The indirections it does have been huge problems, even if they are
"powerful", because we've had lots of issues with recursion and loops,
which are all bad for reference counting - and not using reference
counting for lifetimes is just fundamentally a design bug.

For example, the vfs file close thing has a special
"eventpoll_release()" thing just because epoll can't use file
references for the references it holds (because that would just cause
recursive refs), and dammit, that's just the result of a fundamental
mis-design. And this is all after all the years of fixing outright
bugs (with hidden ones still lurking - unusually we had *another*
long-standing epoll bug fixed last week)

(Don't get me wrong: unix domain fd passing has caused all these
problems and more, so it's not like epoll is the *only* thing that
causes these kinds of horrendous issues, but unix domain fd passing
was something we did due to external reasons, not some self-inflicted
pain)

So this is just a heads-up that I will *NOT* be taking any epoll
patches AT ALL unless they are

 (a) obvious bug fixes

 (b) clearly separated into well-explained series with each individual
patch simple and obvious.

Because it was really a mistake to take that big epoll patch. That was
not a "small and obvious" fix to a big bug. That was literally a
"makes things worse" thing.

I didn't react very much to that patch because epoll has been fairly
calm for the last decade, and I had forgotten how much of a pain it
could be. So I was "whatever".

But this all re-awakened my "epoll is horrendous" memories.

Nam - please disregard performance as a primary thing in epoll. The
*only* thing that matters is "make it simpler, fix bugs".

Because long-term, epoll needs to die, or at least be seen as a legacy
interface that should be cut down, not something to be improved upon.

And yes, I hate epoll. It has caused *so* many problems over the
years. And it causes problems *outside* of epoll, ie we have that
horrendous pipe hackery:

         * Epoll nonsensically wants a wakeup whether the pipe
         * was already empty or not.

and the pipe code has that "poll_usage" flag just to deal with the
fallout of bad epoll fallout.

THAT was fun too.

Not.

              Linus
