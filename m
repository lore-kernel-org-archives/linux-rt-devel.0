Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720096;
	b=iLkQjMWGHH8H/keTk42r2rVFSPrugHB0Y1J6/S57s7wQWeyzJhIUQgbyPNCL7zsO0KPd
	 GpXtHwO4dvtjToDtiqnIC1sHATLTgZJmkrT03k1OATbzRigyLxqoBEBP88qltyvX9K1lc
	 7lyCok2YD2RuvKHQPMSwRDLnQzqBzMaJ88tVlzbO9onG/2wAMS+4zUKQInhQTlbrQ/hiQ
	 3gTBFZxZaRPJfUnTH8+lGZ4Em/UhtMkgYUV3kiT7SiVxzTF3lYqv/dUkWomn4L4UGnrXi
	 utzdweYcOT/szjI7QGmMtCTg5DzS8G/HUGV/cbxYOdWySGnxSO0mp4OH5RfNiJCFRbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HhcRZEH+04vR9Ns2ermSLszSPV9tZtFpE1GJn9nCycI=;
	b=TYp4frSecIfm3oQR1oexrBBGvgE3IE2I5TuB1qHnD0arpqbn7557JoWerUkAHjE7BVvY
	 H1LvxfIY5B2YL5nF3DACIIa6vYjWpRn9+tksftFx2FTerWc4sPUE/7b8FOS29cLUOMAV1
	 u3WaMRkdlwm+aPFT8Fb3Ad9ZGobulQHGJenGM3dNHeh8FPLCXfY/PW1L5TI9cXYF6hW06
	 AXGtlVGMhbq64vAo27l3mJqjcwo8z6VbZNYZsB56TPu3i3f1O7BRzzdU6eUBrxJr4f7j7
	 tabK4mDqkVbnnxg2HxdAQR4Dz4uVM1MeU3DODBySFZCbtmRAj6mByTynCxVVugTQNEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dhc06jJM;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A436606A339
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 15:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A436606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dhc06jJM
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c411e139259so396609466b.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Nov 2026 07:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793720094; x=1794324894; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HhcRZEH+04vR9Ns2ermSLszSPV9tZtFpE1GJn9nCycI=;
        b=dhc06jJM/WWs+wtkqIZS3kH13zLLX9Ev95P3jzVQF5D62B5tFYZAzAO52QgoqCzGiz
         UpmJnR09outDMx86UcCZtMMrVeJ7+DdTvgqNblWthCQhWAB2pc/ycHVVKagOvPgfb9mE
         ziDpFDAbV/apcHrHx2Wk407xc0HefTCeKHSqkOV0BjnvWO7mYx+p6xDd5uOq2SKtHURI
         NzafhcAJchyFv2lHmzeUpspKOZ70+gl4oAFJMxE6LIdSSE4xzQYd9E1ftVnqp503BPr9
         Atf7+VpXPJ9ZlRAi3wXR9y+a/EX7DS3C77pZw6R1HqRSMUSM/7Ed4wSu87nzWIcKxioV
         DOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793720094; x=1794324894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HhcRZEH+04vR9Ns2ermSLszSPV9tZtFpE1GJn9nCycI=;
        b=W+Ej/NHrg1HRU+dTwH3VXEUURs0fQ7at94jnrnwdF3u8eMwP/++V2XQ+vGNa09bXwc
         z3hds79+nnZRmzZOhKEf8IrdizflmfVPTd7RjkHGGPaaQT/3adHJo+gYie60jVi0j6mE
         /i5D5MhiweVOtpo2mZS4MhLk/a8ByfSW4wmuv8V2jUsgwlK5LZ8AH6FNfJ7rE+izudvu
         G6AI0forWMVtlYcH2obAQOuPphQ8xuHF/e5Rt7WhcK4ZrrldBjTwVGaj52tS2966tmB0
         uaMgyVoz9N43Jx7zfcj7ovrOYV68w9OHiEiB8Jc0PX6Y8745nHiZiswIDtkir6nZ+7pr
         kX2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzt0u2koSIGLBIduZpGCygSZLhn6PlxJFrs0C4iTAsfFQww/9CdAvtRk8qb/VzfRLMmDP2mDKNWMw18L8jx1A==@lists.linux.dev
X-Gm-Message-State: APuU4Z9kNkcjnqlqPt+zZOsBr83h4kcGUIhd370kPRp85G4yDQCzFOtQ
	/AEV4QlVLopTbp9mLtUUDgQsVTt1OeYA11HjhmpKLQJTnBp4g2IeGcHA
X-Gm-Gg: AYBFou16wXC7y5KFsIglNDRv9omxFCTQD3Z+1gtNqRkzqZjxGxqRZrVHFolOo5J25BR
	FwM4xETR13fLE1ZXWo34dy+q4TzUqc3/C65y7YIiIWiVY38HFSHzx38X2t+MD+cNPBh9HDdvRZa
	SHixfAI0rw8uCVkWVkeuhhKZ8cQ+cb+03XY+njAfT1/crBtSw+fhGP10jpyY9RtCD/HEPCZyzrK
	HFsZQHC6LWY7G/SlLYQEm8Ji9NaSq4oA5sePrf59OqjtJSCUBC4pgf3qtpppnEQ45ulHZabCbNf
	mkItJHbyYAm3nGxWsqeychSqy/H+GtbSkwso66PmlIVNtFzsARJYTQNaZ5imZDhYUj1rhTfsn9o
	o7oQEC6njHR9HVHuG23mFtqPNznt0UUDz2rsmNP8QG5FnIheeyuoo2jXTVlQqLuccRPTPmOw0ID
	KlUKEhWC8vgNUsyUkvSitC8SShfFVSG8S5ZFJOV7FIw1JO+UXgkv7jmEVb9YZLBJss3/RBPBnLu
	LYCAnTPsJ4FqX01zw22giWEXK953ConpJWd8SXMWXqnZUwM5j26Za9Rbv7/ePiDNgtyS2h6zwWQ
	dJPPecvxVh0sv8sv231WwX51S9VPY3aIfWfnprlmpqh506q8sn32qMA5ydASfF0zi2L/YvxoPyp
	KSg==
X-Received: by 2002:a17:907:9346:b0:c49:b9b6:4b5e with SMTP id a640c23a62f3a-c4ca7b1f727mr1085268366b.20.1793720094382;
        Tue, 03 Nov 2026 07:34:54 -0800 (PST)
Received: from andreayoga.wind3.hub ([31.189.68.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e7a1d9d71sm20358929f8f.48.2026.11.03.07.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:34:53 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix spurious -EPERM for migration-disabled tasks
Date: Tue,  3 Nov 2026 16:34:41 +0100
Message-ID: <20261103153443.187455-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103081149.DuyWNhVe@linutronix.de>
References: <20261102135420.244745-1-parri.andrea@gmail.com> <20261103081149.DuyWNhVe@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 03, 2026 at 09:11:49AM +0100, Sebastian Andrzej Siewior wrote:

[...]

> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks!

> Looking at sched_setaffinity(), there is dl_task_check_affinity() which
> makes the same check. It is skipped for !task_has_dl_policy(). This
> looks time like there is a small window in sched_setscheduler() where
> the affinity check passes, the task is not yet DL, and then
> sched_setaffinity() makes the affinity smaller.

Agreed.  __sched_setaffinity() calls dl_task_check_affinity() before
taking task_rq_lock(), which only __set_cpus_allowed_ptr() takes later,
whereas __sched_setscheduler() runs the admission check and switches the
policy under a single task_rq_lock().  So setaffinity can see a non-DL
task, setscheduler then admits it against the old, wide cpus_mask, and
setaffinity finally narrows it.

The window may be wider than it looks, too: it includes setaffinity
waiting for task_rq_lock() while setscheduler holds it, so the two only
need to overlap.

That's independent of this patch: the same happens with p->cpus_ptr.

restrict_cpus_allowed_ptr() already does its DL check under
task_rq_lock(), so doing the same in the setaffinity path looks like
the way to close it.  One thing to keep in mind there: when
__sched_setaffinity() races with a cpuset update, it calls
__set_cpus_allowed_ptr() again to reset the task to the cpuset's mask.
That second call should probably stay unchecked, as it is today, since
cpuset_update_tasks_cpumask() narrows DL tasks without a check anyway;
refusing it would leave the task allowed on CPUs outside its cpuset.

I'll follow up on this separately.

Thanks,
  Andrea
