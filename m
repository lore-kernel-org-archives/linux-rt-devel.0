Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302B2566
	for <linux-rt-devel@lists.linux.dev>; Sun, 13 Jul 2025 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752370518; cv=none; b=iwKd8GAadPRSaqLo7z1q7/1dBMUU/s6HHi5SkfLv+emVafuwv8VCtM6nzvYsqwiavTGRG06mh8fQtSyhauaUK4EGlOPcX1Ve4TvTxFjhe5YU+aafBDcGyzVv8evxxJGroRLK59Sz5khJ2/9xsH8p2w0JQMtU7WtX/1E7msjw4uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752370518; c=relaxed/simple;
	bh=K3TeXBj3Ce+xFB3ZDrkBEp2HkCMjY8mrws+L09Uloow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLYsCqd2nTpxhorC+Y/Hf4ITNRPUERiVJUr/xQJcvINkZ49/1LZ/jvDRW9bUl0aNAlh195dszcyaZ0VtyOT9GYijmLzmZvuu7pliyRhLWpMwRY6hbhVA4+vjGpKPK8shhk7v1dPfa6Ghje/WOW1Xag/hPklm05ONPunX/iI3M2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6pLxIDz; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6pLxIDz"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso3583551a12.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 12 Jul 2025 18:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752370516; x=1752975316; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1kIuH5vbQd+FTCmx9ylanJ8cVlQcaHabEKmMN3G/wM=;
        b=h6pLxIDzOKdr1r+uNMtsxEk/+SgFkwy4H/pajm7n6W8ApEKqsL3y7xADLQ6KpFoQXS
         KCXrxH1HjaBxs5cYY93WtI6+8gODIoOCdVNL4SFNWafv9Azz5fftZh63x+Hxzbkj7iws
         VuJ/37vSXTQMFl2UDGNTFaAPfRfPlYTChMCXmRaEplIjX3XcJXsnwtZp8DoKfOjl4xlN
         68BgdQMGsflMg7IV8sW8iCHds/F7M9GUu/F8gd/jEiT0gqBRPmvu7/T8vSuVNBNCm9qu
         T0A5H2EOi56W2/6iuCXP52D93sqcuyYq57UkMLCHJaRbwTFxqWo4kXK8UVFTvgVmsoed
         jTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752370516; x=1752975316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1kIuH5vbQd+FTCmx9ylanJ8cVlQcaHabEKmMN3G/wM=;
        b=AZ1DSELYrLegF+KrEDFWKctQYgGPH9aJulsi7YflQa9xY+gojewSpQSfbAbeE7HKP8
         ++/Y4ad7uRV/Y/kPDh+Wo+6KtUbUVHaI4T98P//NSaKreyHC+AImnWVEMz2gzbQs7jIc
         5m8ziO3e4kSEUa0xu/gVhDHsmtk6mMcCH0D7isT8y/BpW8CYYe2EjEtCaUK22PRmeBxS
         TOkfCijQJqMFHuSfsIZ3kraApqJupqHQTw1D2H6g18C5njhRQypmLGQqG6+i56eCrqoh
         n7mLIyMZwpVTFVvxi5dvKkZ2bXsYY3PNgMQLmPG4GYoxTH4kGDilAfUDurE3avfgR3QA
         5/fA==
X-Forwarded-Encrypted: i=1; AJvYcCVpoK2//crh6C4Ifl3vfCGkfQ5ZOhBFINtXthIq2pgxMYAdwyyEUNPv9q+OE3xUR9GLP4/nlN1Jv/gGXfQsBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvLnnX1B2rksaznaT5ObyD10WL9LCnyMsopyNbIAlCZPl5vZXh
	O1M3tfQUYWDSKUqGRapl9jdcVxubeNqTianOt8E/LruxsT7PUaq9Neee
X-Gm-Gg: ASbGncuTLmd/yrqqqX5JcNVYFcUxFafEuaWrQxGfa2I/lhTwUbPww98wEeA+rUOqNNJ
	+Y8pwWjia9LY2RoPKY2S85sfZOIH0UBWc/dJhPQPMm6/S9lMdFynf+QAv6hlrF1H8MKovm+MWHH
	4L2AwXA07PcxFeAO7DtqYaWhQ+ajnNVYhXyT6LuHyuUNAAcARuA7Hl5pkxmenndIh2wF9KiSqPH
	Tx13ErukkiZ6lSpyxySnnwTJVQNszeBLt6WRp14WtbYpPAHvu1H22jQS/v+DLnJ5GosH82CftfP
	aR2BDIzJTJeD5fNRo/doxAkZi+2E+lwNOAC4sQf+ImR5M6MjJ4lJ8wjiyLO18YDQkQ9T+hP1F2/
	/NXGI3TzaBCLcMK+MK7tEunQ7I+Lq8MU6p3DrZpJcwTH1KPxA2YhEaZd+i0dYM0410YZbyMa/Xw
	yaR5lsPRO6IqpJUzMo
X-Google-Smtp-Source: AGHT+IE51vSlxcujLC1zUQoeSyHLVKUuxpMpvj+mod4W2u2bTt0MhQlRD2uXH10sTRYqoWbVW0AoVA==
X-Received: by 2002:a05:6a21:3990:b0:1f5:931d:ca6d with SMTP id adf61e73a8af0-23135d67a1emr15466908637.1.1752370515718;
        Sat, 12 Jul 2025 18:35:15 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e058fesm8055261b3a.40.2025.07.12.18.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 18:35:15 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: jindrichsindelar@eaton.com
Cc: bigeasy@linutronix.de,
	kprateek.nayak@amd.com,
	linux-rt-devel@lists.linux.dev,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com
Subject: Re: softirqs causing high IRQ jitter
Date: Sun, 13 Jul 2025 10:35:11 +0900
Message-Id: <20250713013511.221845-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SJ0PR17MB5559DFA08F96F9A6E2E2E4DFD74FA@SJ0PR17MB5559.namprd17.prod.outlook.com>
References: <SJ0PR17MB5559DFA08F96F9A6E2E2E4DFD74FA@SJ0PR17MB5559.namprd17.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 7 Jul 2025 13:05:40 +0000, Šindelář, Jindřich wrote:
>On Wed, 2 Jul 2025 13:09:09 -0400, Steven Rostedt wrote:
>> I think you may have found the main issue. That is the timer softirqd
>> will pick up other softirqs that are pending. Yes it is a separate
>> thread and will wake up to handle softirqs when the timer softirq needs
>> to be handled but I don't see anything limiting it from handling other
>> softirqs.
>
>Thank you for confirming this. I am now leaning more towards trying
>even more separation, to achieve a state where, if handle_softirqs()
>gets called in a context of an IRQ thread, it will only handle the
>softirq raised by that thread, leaving the rest of pending softirqs
>untouched.
>I have an idea in mind, but before trying, I would like to understand
>a bit more how the bitmask that holds the pending softirqs is protected
>against races. There's this block of code in the handle_softirqs():
>
>        // ...
>        pending = local_softirq_pending();
>
>        softirq_handle_begin();
>        in_hardirq = lockdep_softirq_start();
>        account_softirq_enter(current);
>
>    restart:
>        /* Reset the pending bitmask before enabling irqs */
>        set_softirq_pending(0);
>
>        local_irq_enable();
>        // ...
>
>Here, local_softirq_pending() and set_softirq_pending() access the same
>bitmask, and AFAICT, the code isn't surrounded by any lock or critical
>section. It is true that (hard)IRQs are disabled at that point, but to
>my knowledge, preemption is not. If all that is true, then a softirq
>can be set pending in the meantime and can get "lost" by the
>set_softirq_pending(0). I find it very unlikely that such a mistake
>would be there, so I'm probably wrong here. Could anyone please tell me
>what am I missing?

I'm afraid I might be wrong, but my understanding is that there
should be no scheduling happening if we disable interrupts (like
timers), unless we call for it. And the path in question has no
code that could trigger scheduling, so it should be safe.

I believe its documented here[0].

>> I tried to come up with an idea isolating (hr)timer softirq from the
>> rest. Would be nice to get a comment!
>
>Thank you for comming up with the suggestion. There will be people who
>are more entitled to review this than me, but I will try to comment on
>what I see.
> - Your suggestion will not only modify the behavior when called in
>   the context of the timer thread, it will apply anytime it's called
>   outside of the ksoftirqd (including IRQ threads).
> - IMHO it would be nicer to signify the fact it's called from the
>   timer thread with a function argument, similarly to the ksirqd one
> - I would avoid reordering the softirqs and instead of re-raising
>   them in the loop, I would suggest to only clear the timer related
>   bits in the place where is currently the set_softirq_pending(0).

Thanks for the comment! It was my intention to include IRQ thread as well,
and I wasn't really thinking of distinguishing the timer thread from others.
If we were to signify that its called from the timer thread, I think what
you suggested works better. I also think its better to clear those timer
related bits to be executed rather than reordering the softirqs like you say.

> - Your restart logic would mean restart never happens with PREEMPT_RT,
>   including when already running in the ksoftirqd. I'm not sure if
>   that's desired.

Oh yes, ksoftirqd should better be allowed to restart. I should have
given more thoughts to this... Thanks for pointing out.

Sincerely,
Ryo Takakura

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/locking/preempt-locking.rst

>Overall, as written at the beginning, I'm now at a point where I'm not
>sure if the isolation of the timer softirqs will solve the whole
>problem we have - it may still happen that multiple pending softirqs
>will be handled in the context of an arbitrary IRQ thread. And trying
>to completely avoid the execution in that context (leaving it only to a
>low-prio ksoftirqd) doesn't look like a good idea either, as ksoftirqd
>could get starved out on heavily loaded systems.
>
>Best regards
>Jindra
