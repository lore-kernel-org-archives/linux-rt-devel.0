Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD73ABD91
	for <linux-rt-devel@lists.linux.dev>; Tue, 12 May 2026 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616621; cv=none; b=NnxDfUHaS2NWyBaPNBwxh2exHEkZcwPwqblUF613rRtotB2tLwmyK4zAHSkyODQBQEptBNvyy80yTHhhMrnXM1L8jgMnzDrMIYt3Ze9H2Qjnpdd8hcBWQAtfYn0C5OUJYUJo2agZ6dlA5+8hAdn1LqVsQo2+gM6CRirp1au7Dls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616621; c=relaxed/simple;
	bh=+JCrXZhZYw+RI/HVQxcPYXVfM8JoeJKwt7zyODuIkGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X1GvXgtSCrFrAd1e+dHIN3cnxJoKrbSBBS1gkYVLmZYDDGCdr6HKwiVIMpc8GhJ2xfuUXziPxYoEO5etYDaaU1uHLHnnp63SU+vjc30FjiMUhoFBaUAxvW9LJ1xOVl1rUtt7/xxiFPBcsUNjcgBmDAScfaDtR8W4YoYALLVGj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHgCVbbD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHgCVbbD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778616619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TPYnN5bYSdRlPVznuXaA8Mz0mx5Mw6QHeHl/iOKTNFo=;
	b=LHgCVbbDHFvBZP3214kd3SPpU44ODVDpZNBKbdD9z5SIPFuwO7D8TwbpwN0l9cbgq2Nrh8
	4SbhM58U+AK3eE+OaNb2xF7XZAvWCkxiomHgFry8ENIDp8BBE3cN+Sbm92c0PVKIGFc9aq
	BmuuvbLMc1p0s39X6R6BlCNcWSGgdIM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-O-Jx8lN2PzWfe17kfgzIYQ-1; Tue, 12 May 2026 16:10:17 -0400
X-MC-Unique: O-Jx8lN2PzWfe17kfgzIYQ-1
X-Mimecast-MFC-AGG-ID: O-Jx8lN2PzWfe17kfgzIYQ_1778616616
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4411a1f9601so4524763f8f.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 12 May 2026 13:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616616; x=1779221416;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPYnN5bYSdRlPVznuXaA8Mz0mx5Mw6QHeHl/iOKTNFo=;
        b=U0HUtjKIA37qyhFwAXUykwOk9q77eL0ptFuf37tUhb5+9ESvxkmsoEHfHyg/sxkzB5
         YwVN1HSW0ekU4UbZPj5WyZ8YdLU6LCH31rBg+s1FzkMeDSkcNMljTsyo6r4EpiCeQa0J
         zQCbXBsWr8SqHo8tA1BkRcgtryNru5Fmb688B8PBoEzhTbdbw+D5oEpfNBnVcUFFnn47
         NvQwusMOuiN9R9W/JhsWHi9+uncP7sJ7xfonB97Jyyvj0auczHqWwgCkLIVSFbS2mOOR
         D13B/PjR+K1DKnNjLsl8ZwXc+iLTadgBzpZUzF9BolhcGxTa8zHuvYevGN1cpumWtCfv
         4cNw==
X-Forwarded-Encrypted: i=1; AFNElJ8Rwf1P/KSe7pTZtsF9e+xLBychCvNllbjbtEMqA6lmGJGc8xE+if68OQmnGjaSxrmy+u73Y8UvL2hRiTyjnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdRL9ktn85Ht5WFIagSE7aeI5/inJDRIt4Bk5Jsiv2dhXNbpni
	3h3l+ihmp6Z+1XK4aYijHvqk0wel5YpU/NgMddNoGiyo7co3os82nauZnAz2wn8ZLqEpzQPUaSg
	fQWHxoPOVKMHi4joNMDNDKqXpIIHE9OZxOLw8LN1HfRFOZqkmKnSFF/PtzVvgD0w7B4EJ
X-Gm-Gg: Acq92OHcZU6Y8x5MsccHAhIFaid9xHz3FAe3LF5pFs8O+TYrKRe1ENdLA1nu64BHW7Y
	RmXiqHG4AQ1cLkq6JYYdLRi73FkysKBKXXmyzxGPrvcM9HLblwZ40qEQ0MTlBsqfAdB5qXra6WV
	QQwssiCzawWCW14qBAb0sdSCIt2KGOmnVw/znhK8Qk28uQegbyoEX8h/cZ99lXbHFjfSt4+bGCm
	g08yenXqcEZWzWsxIoK1aMmjIMU734c3867lr54ABimgZfi13Ha+ndZW/Ip5XnGg+HBW7uTQncv
	UKhc6h+SsdwsGrk/Px5AmmfoPPGO6b0IPBzo4GzGHEQD3xJHQUYuRY22ahBmNHpiRrWO00Utpg3
	1oJFdOHuSqErGSx7WEru9BwAW0O7FWENF98FsJev3xo2xGJRcV02KNx3o6v4XlJYpSmAKja7LGb
	kD7hbUMDE=
X-Received: by 2002:a5d:5d83:0:b0:43b:4982:fc73 with SMTP id ffacd0b85a97d-45c599eaf6amr315864f8f.25.1778616615810;
        Tue, 12 May 2026 13:10:15 -0700 (PDT)
X-Received: by 2002:a5d:5d83:0:b0:43b:4982:fc73 with SMTP id ffacd0b85a97d-45c599eaf6amr315829f8f.25.1778616615280;
        Tue, 12 May 2026 13:10:15 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491da03a7sm35256124f8f.33.2026.05.12.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:10:14 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Kyle
 McMartin <jkkm@meta.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Linux RT Development
 <linux-rt-devel@lists.linux.dev>, Clark Williams <williams@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Kacur
 <jkacur@redhat.com>
Subject: Re: [PATCH sched/core] sched/rt: Fix RT_PUSH_IPI soft lockup loop
In-Reply-To: <20260512113754.448c1f5b@gandalf.local.home>
References: <20260506235716.2530720-1-tj@kernel.org>
 <20260507141437.GJ3102624@noisy.programming.kicks-ass.net>
 <20260512113754.448c1f5b@gandalf.local.home>
Date: Tue, 12 May 2026 22:10:13 +0200
Message-ID: <xhsmh8q9o2xui.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J5KRPDZc0Xnu9CSY0K6eq3lwglzWdMCvvcZ97MGIcuE_1778616616
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 12/05/26 11:37, Steven Rostedt wrote:
> [ Adding some RT folks ]
>
> Also, Valentin, can you look at this, because I believe the issue was
> introduced by your change (see below).
>

Woops!

> IIRC, the test we had was simply cyclictest that we ran with the following
> parameters. From commit b6366f048e0ca ("sched/rt: Use IPI to trigger RT
> task push migration instead of pulling"), it states it runs:
>
>    cyclictest --numa -p95 -m -d0 -i100
>
> The above runs a thread on each CPU at priority 95 and will sleep for
> 100us. Each thread should wake up at the same time. You can read the commit
> message for more details but the tl;dr; is that without the IPI push
> request, if one of the CPUs ran another RT task besides cyclictest, then
> all the others would then ask to pull from it when the other CPUs
> cyclictest would sleep. Having over 100 CPUs send an IPI to pull a task
> when only the first one would get it, caused a large latency. Especially
> since it took the rq lock over and over again.
>
> But, the code being fixed wasn't due to that commit, but due to the commit
> that added the short cut of the logic. That commit fixes a race with the
> normal call to push_rt_task() and I think the pull logic issue was a side
> effect.
>
> I agree with Tejun's change, it actually puts the logic for the IPI pull
> back to what it was before commit 49bef33e4b87b. The bug was added by the
> shortcut case to push_rt_task() that was only meant for the !pull scenario.
> Adding !pull to the if conditional seems like the correct change.
>
> Valentin, can you confirm please.
>

So looking back at the original report for my patch:

  https://lore.kernel.org/all/Yb3vXx3DcqVOi+EA@donbot/

the splat happened through rto_push_irq_work_func(), i.e. with pull=true
(that naming always causes me to shuffle through my notes; AFAICT that's
because it's when push_rt_task() is invoked due to a pull_rt_task() call
but urgh).

So IIUC I'm afraid the suggested fix would cause the original issue to
resurface, but that still leaves us with the reported softlock issue. I
don't have any inspiration so far, I'll sleep on it.

> Please update the Fixes tag to point to the appropriate commit as well as
> update the change log. With that:
>
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
>
> -- Steve

