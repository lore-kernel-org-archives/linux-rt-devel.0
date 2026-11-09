Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219458;
	b=mB0BOYXqAOuMIgvYysu4NklqTNy5T1HPXrqvCeJ3Vk4wMU5DM/I2ZjvQ6WKR7zy16y58
	 RnSw76FBfZT6pnUzF6r7TYZKpbQICPhFcOxxxX40eEruBmE2Bu2JgkDDysVqEaw207bW4
	 GGP0SnVB3biSV0wU6KK4+2ot8dAWzbGPeJaqMl+4PStGEpTQUAHxfA3FVoXfijsLokl31
	 sjQ+NcNpbrUEKt8Dk9AWs2VDCyUh0hWC2pPIah/ZuFPIXC/5kchXH4TsHC1XJq9qnu3XP
	 U40tI68sf4bhv4EgLUo51KOq+Uea4Wy0ZmTlW2qJ2DAcAQ2OxjMYMT8X2wga7G2RtFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219458;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:In-Reply-To:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=qEpeXh4n+Ip6h8mQUL16hZLbonLzBsEE2lau1nHqEmo=;
	b=gbAHTaLgCH+rdEsoqalNPXRYE4RUuMvB7pX/RokgXwnAGqQNJLv6idrk0R1oiwmOdwZ8
	 uSLeEqjA8VQBsP51uenIh4mLUsqiAJJsGGOT9/kS3Bm0EkZyPNIix2D0hOK0w6agFANxT
	 ovlG+D3azPN7G/MPzyGLg7ZCzen3ezzQDpw7ceH3YzVvsAwp0+azC8g6YSB3BQ3FVvWSQ
	 AY/OVU9FNoZVME18W+Zo04tL3yA5Ov3lm4ynS9IQrx+zQn3qdQs8LJKqVTIC/dj2mls2D
	 Uj48ZbzDpUH6qgKTu7zJ56Xw4YT7T+AQ0bVS2DS4U4u1nMTnUHrtJyVGgILJeC7Hg8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SYSseT9J;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E901606EE9A
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 10:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E901606EE9A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SYSseT9J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794219456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEpeXh4n+Ip6h8mQUL16hZLbonLzBsEE2lau1nHqEmo=;
	b=SYSseT9Jy/WFz6WVEQnxyGdvA31iEpfH9eel+Zh4l7BmosTfd2yqb8ywOJP3F1AVZRNeg5
	aa+84ZKKLzl/TqB0SaTPHCnK8h/8gjYa9qqx22T4rfSuxZnHTBxqCOrmAXovhohUQzb1gc
	sVS28RI1ga/MsxTvIUrRtULxmVUfwtc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-Xg60oddgPauRJVNGHWGJxw-1; Mon, 09 Nov 2026 05:17:35 -0500
X-MC-Unique: Xg60oddgPauRJVNGHWGJxw-1
X-Mimecast-MFC-AGG-ID: Xg60oddgPauRJVNGHWGJxw_1794219454
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4afef353dd2so8396005e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Nov 2026 02:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219454; x=1794824254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qEpeXh4n+Ip6h8mQUL16hZLbonLzBsEE2lau1nHqEmo=;
        b=IKv8CNfo04QhbDC3ZYvxzhJ1uMQuMxGCrqn+GaWErxXJ33st/kFKMLWqT4irpAMNUG
         QGundXshRzioSVIvyUKNqp9Za2AEWh5C8RjoV8nyrOaeswzl/iwu6fE/LyxRNqDiSMYr
         dtux3HlD9XOiBBeSutjG+QL7M/Z70GDG3N/PHXWn4vqTNkTLoy+q16q32i7urCwXgjHT
         4iG5LX3M+FiIMUkfuD2nbbDkVPvA7fBrrbXlg6dsDfTSn5EulbJMxFYb6mdzLdtZ1rGa
         MRXR/jxlOJKthC15FUndEB8FmIIApiIU6bPg7vlf1kzzO9SsFNYpA9XNzc51SG0iQAGG
         NyjA==
X-Gm-Message-State: APuU4Z+nlsbefKqcdyJW9i2CxQAQ462st6TbszQ3/8ze4+jhjBAC0zQS
	BEP13D6HfdsZOlnQXCcdrN49oCr6teOv/Gat55KIe8etOCm/6/8K5JU9HQRdzZnJ4AU9aoQW1jb
	pSqJ0Fsl1KAD6/apS1/1fC2s41A3yocWvJklBRpKQaLFd3yMd4pJHVRWZljhefxOW/Nkk
X-Gm-Gg: AYBFou2eDOO+S1EtvrX4HhjnDtDHQiaJS25zaJcrwxEy84YhaVdkY02a9YAEMO6yZb3
	KAeueAg2NQSetx8APNjApP3j0n/bQhFjYrbLlscf8rWEhZ2uMx67dDCN1O/+44zVgzAWxFZseK/
	OuXnmimHdE3B9L8F9Ir0nFADKpCjKKUnKIj/DrWk2lMGju4GqBVmDypZ2zBCg6nZCVRuCwel5IW
	uvrj1dVTvzGBjoBxww+46JhjVD74Ac/s5m6YoPunLW9LE6MwS1y0fCRVv61Ur+VfsWbCEUs1uQu
	L0Gbha+15xL1JeBtbIFfxc2YdMf1Y9XskckVj3RVuC/O5W1kh1ZPfBu/j2nowQiXgDJZhtlQGoV
	0qfTDLadJ4YNvoWZOOnu0c/FavXh7ZFvVYBUEenEoyApKx5+MrYBUY4MumIobnUxH0Iq01hI0YE
	9pvg==
X-Received: by 2002:a05:600c:4e4e:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4b94d763141mr64174745e9.2.1794219454207;
        Mon, 09 Nov 2026 02:17:34 -0800 (PST)
X-Received: by 2002:a05:600c:4e4e:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4b94d763141mr64174325e9.2.1794219453808;
        Mon, 09 Nov 2026 02:17:33 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b9f93c04afsm71663785e9.3.2026.11.09.02.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:17:32 -0800 (PST)
Date: Mon, 9 Nov 2026 11:17:29 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [RFC] RT throttling, DL/ fair server, RT_GROUP_SCHED and
 everything
Message-ID: <avGduY8yVmZSfpMf@jlelli-thinkpadt14gen4.remote.csb>
References: <20261023161348.t3lpPLQZ@linutronix.de>
 <at8J1mimeQ2oPZDE@jlelli-thinkpadt14gen4.remote.csb>
 <20261105120932.lSBBenqn@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261105120932.lSBBenqn@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s354zwl5WpJ5IKmIg7mVc9UHTJSxaBlgWv8ayZWrqQk_1794219454
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 05/11/26 13:09, Sebastian Andrzej Siewior wrote:
> On 2026-10-26 09:05:42 [+0100], Juri Lelli wrote:
> > Hi Sebastian,
> Hi Juri,
> 
> > On 23/10/26 18:13, Sebastian Andrzej Siewior wrote:
> > > Hi,
> > > 
> > > this is about the old RT throttling mechanism, the DL/fair server around
> > > the RT tasks, the /proc/sys/kernel/sched_rt_* mechanism to control the
> > > former and CONFIG_RT_GROUP_SCHED which never worked as it supposed to.
> > > The current status looks like a mess and I'm not sure if there is a bug
> > > somewhere leading to my headaches or if this is just not meant to be
> > > working together. If so out with it.
> > > 
> > > tl;dr /proc/…/sched_rt_*, sched_rt_runtime_exceeded() probably
> > > CONFIG_RT_GROUP_SCHED should be removed. A bit of docs should be added
> > > for the fair server (or the right place).
> > 
> > Thanks for putting this recap together!
> > 
> > > Now. Details.
> > 
> > ...
> > 
> > > Without enabled RT_GROUP_SCHED the files can be set. Are they useful?
> > > According to Documentation/scheduler/sched-deadline.rst it used for
> > > "admission control" whatever that means. Anyway the fair server still
> > > kicks if it is disabled. So I *think* this is just something else and
> > > not part for the docs there.
> > 
> > Right, confusing, but for a root_domain comprising M CPUs, -deadline tasks can
> > be created while the sum of their bandwidths stays below
> > 
> >   M * (sched_rt_runtime_us / sched_rt_period_us)
> 
> My understanding is that this is the runtime available to a DL task and
> the length of a DL period (after the accounted runtime is reset). The
> left over runtime (of runtime is less than period) is either buffer
> (idle) or SCHED_OTHER runtime.
> This defines how much runtime a DL task gets from the system, correct?

How much bandwidth (runtime/period) DL tasks get from the system
(comprised of M CPUs). And a corresponding cap (no more than that will
be allowed to enter the system) - admission control.

> > and writing -1 disables the check altogether. That's the "admission control"
> > the docs hand-wave about, and it's also why the knobs can't simply be deleted.
> > As you noticed already, the servers are completely independent of these knobs:
> > writing -1 does not disable the fair server, it only lifts the DL admission
> > cap. In principle we could move this to a different interface that reads closer
> > to the underlying purpose, but I'm not sure how much breakage it could cause.
> 
> That is my point. The rt_ runtime/ period is about DL properties and not
> RT as in SCHED_FIFO/ RR as it once was. Both are set to one second as of
> today and can not be changed with enabled CONFIG_RT_GROUP_SCHED.
> 
> Could we please move it to /sys/kernel/sched/ and rename it as dl
> something? Is there any reason to keep as-is? There is
> 	Documentation/scheduler/sched-deadline.rst
> 	Documentation/arch/arm64/asymmetric-32bit.rst
> 
> referring to it in DL context. There is "ftracetest" writing
> unconditionally -1 as a workaround, see commit 57c4cfd4a2eef
> ("ftrace/selftests: workaround cgroup RT scheduling issues").
> 
> If the runtime/ period arguments are fine then we could keep
> it and make them only apply for the DL period.
> 
> Two files have been repurposed and if your intention as to disable the
> RT throttler then you will be surprised.

Right, it's indeed confusing. I believe the intent for keeping as it is
today was that in the future, if we get to 'fix' RT_GROUP_SCHED with
HCBS, the existing knobs will be control both group and simple DL tasks
bandwidth (they share the same bandwidth). I'm not against making things
clearer. Maybe let's hear from others what they think as well?

...

> > With 820725b0eb59f ("sched: Add deadline tracepoints") we already have
> > some of that: sched_dl_{throttle,replenish,update,server_start,server_stop},
> > which fire for fair/ext servers too (there's a type field, DL_SERVER_FAIR
> > and friends). They of course require something like this [1] to be
> > activated. We could add more if they are still not enough to get a clear
> > picture about what's going on.
> 
> Hmm. You may want to merge Qais's current master to get it compiled
> again ;) But then nothing hooks it up, so I just replaced with with
> trace_printk() just to see what happens and got:

Ack, yeah, I didn't use them recently and they rotted. :/

I will try to find some time soon to refresh and check what's missing
from the information they provide (from a debugging point of view).

Thanks,
Juri

