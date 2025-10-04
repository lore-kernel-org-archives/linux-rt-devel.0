Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3010E18FDAF
	for <linux-rt-devel@lists.linux.dev>; Sat,  4 Oct 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759566855; cv=none; b=qnr39De9qjrIrDq2Mku/5qrMgu9G5JhioAqKE0slvTy9ZVJTY+NUDhImPj27wRdYQiwueGYTqeixSIxvDitKWf7JCeCTH9AQbXCCH8ARMg8T7rhiaGHCjWaG0LSpwAPrH3G2iqXcDSIEhbKwlujT+yFteJcdf8zCM7VsSv5/o8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759566855; c=relaxed/simple;
	bh=ewAScujQh6IO+nNyoKcQ1124xJn4eyXuYWjb3HxVNyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oDhfKNWRBVWz1vB87/b0VWtgAp9QgPuVK/6zmsah8SsN9VVoCo4jACvnWHPpmjisygrmhEGOMrJte/nrIzbtjL6/lzIsFqpUqg4QfNUaNEC9HMw4/HB21yEgtnzDMUEvRRXyogWabqwILWhxEjJuhnzmsdUPWfEBf9TUVWNgdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqJsWQyD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqJsWQyD"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4c72281674so1952638a12.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 04 Oct 2025 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759566852; x=1760171652; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DNUXIAMIgyuQcbpSIlbWyb8Yr08Un31/NnbXWZYjsP0=;
        b=kqJsWQyD88yNIj89pFEzNv1/8c7rNKpJEea2iftrWgGYquMmk2OnA1gtq6KdNpoK5d
         iNsva05Ftu9kzstSq7gNG3wXYXaW9kOzMRHjKfI3GTMjgQCxhQjS0vskkxHVbPyE1KJk
         lKfzlw4toI37j8G15+H0bPtcnIsq3eNcgGs1sXSSwkWVFRmsL8A9crs4Wif4SLVoty4p
         hXf6lmxR+qcmp194jDy+FwDYP1E3ps/RDUFLknjSfG5YnWQh6hmlfelzthT9n07Gr+/Y
         jHu9U1+XBJr/Z+qrASSucwO/zNoLgC3+j6XuL9knMlsdrie6u8E0+/W/k7kUMdTtYfN0
         vzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759566852; x=1760171652;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNUXIAMIgyuQcbpSIlbWyb8Yr08Un31/NnbXWZYjsP0=;
        b=vGKYiYoqGv9TxFDB5QzQBNhzARa8K5Ha0DD/e0WcWq/aJO2mEooYR9Fpv2aI56NK84
         bWoGJXm1Ipt8UL/WU712seGCxGZ9HztUlIVTCiESkc5uXclsJqWb7duNMQPCuxe0cOjP
         8reMKD7VOfKkEkrPVjlV1rkvwRJ3PcJmnaDhNbPdPzXapfclFYYvrd1l7oCuWO+Fdu1L
         1km5GkOmnjZRvKTeLEJCc72y5ORQ8QyP63ZdqdmcDU2u4G/vH1DFo1TwNuLxtDCXYVRL
         sSqUhsao9AGvMBrm/94sxZsbVbZ2k/nO/MweRQ5DwfEkBppaUb5voM1hcVcSc0MPhoNA
         zFEw==
X-Forwarded-Encrypted: i=1; AJvYcCXXKyioN6xUwv1YniKxIkWMVFbIRmWQG3v8RpFxlORavOm1OyB2J5GvqAFNw5ijgPUXmW0DiZHDIASUF/HgYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmlYk6x/3eK5tTkLbLxQ5/owYNcfpZqxb92RIELVoqm/zgIYk+
	3sexnnqoussAmKyBHedeOEcEZQMA7CQ0syQu5Y9+bV5owO6JZkir+JPrV0Ke83twDlAHV5609Vo
	u+lX6nMKJgA==
X-Google-Smtp-Source: AGHT+IG8WMGHaurimhri+gW5zRlp6uwHUCV2xHoW/prUeoq2RpfxaFVx0IibIcEVP1lg9S9cRSoC1Wbb2vOb
X-Received: from pjzh5.prod.google.com ([2002:a17:90a:ea85:b0:32d:e264:a78e])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec6:b0:330:3fb8:3885
 with SMTP id 98e67ed59e1d1-339c276e814mr6792475a91.18.1759566852200; Sat, 04
 Oct 2025 01:34:12 -0700 (PDT)
Date: Sat, 04 Oct 2025 01:34:10 -0700
In-Reply-To: <20251003114555.413804-1-nirbhay.lkd@gmail.com> (Nirbhay Sharma's
 message of "Fri, 3 Oct 2025 17:15:55 +0530")
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251003114555.413804-1-nirbhay.lkd@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx87bxbvzel.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH] cgroup: Fix seqcount lockdep assertion in cgroup freezer
From: Tiffany Yang <ynaffit@google.com>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Nirbhay Sharma <nirbhay.lkd@gmail.com> writes:

> The commit afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> introduced a seqcount to track freeze timing but initialized it as a
> plain seqcount_t using seqcount_init().

> However, the write-side critical section in cgroup_do_freeze() holds
> the css_set_lock spinlock while calling write_seqcount_begin(). On
> PREEMPT_RT kernels, spinlocks do not disable preemption, causing the
> lockdep assertion for a plain seqcount_t, which checks for preemption
> being disabled, to fail.

> This triggers the following warning:
>    WARNING: CPU: 0 PID: 9692 at include/linux/seqlock.h:221

> Fix this by changing the type to seqcount_spinlock_t and initializing
> it with seqcount_spinlock_init() to associate css_set_lock with the
> seqcount. This allows lockdep to correctly validate that the spinlock
> is held during write operations, resolving the assertion failure on all
> kernel configurations.

> Reported-by: syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=27a2519eb4dad86d0156
> Fixes: afa3701c0e45 ("cgroup: cgroup.stat.local time accounting")
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
>   include/linux/cgroup-defs.h | 2 +-
>   kernel/cgroup/cgroup.c      | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 539c64eeef38..933c4487a846 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -435,7 +435,7 @@ struct cgroup_freezer_state {
>   	int nr_frozen_tasks;

>   	/* Freeze time data consistency protection */
> -	seqcount_t freeze_seq;
> +	seqcount_spinlock_t freeze_seq;

>   	/*
>   	 * Most recent time the cgroup was requested to freeze.
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index ab096b884bbc..fe175326b155 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5789,7 +5789,7 @@ static struct cgroup *cgroup_create(struct cgroup  
> *parent, const char *name,
>   	 * if the parent has to be frozen, the child has too.
>   	 */
>   	cgrp->freezer.e_freeze = parent->freezer.e_freeze;
> -	seqcount_init(&cgrp->freezer.freeze_seq);
> +	seqcount_spinlock_init(&cgrp->freezer.freeze_seq, &css_set_lock);
>   	if (cgrp->freezer.e_freeze) {
>   		/*
>   		 * Set the CGRP_FREEZE flag, so when a process will be

Thanks for this fix, Nirbhay!

-- 
Tiffany Y. Yang
