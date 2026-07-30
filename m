Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE79E37CD59
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Jul 2026 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379836; cv=none; b=rKcGx+S9o/7+z4THckgPaKQq/LBOLxvistQmy6viiOOuemMsJymbvU9guX5cTY/3gOxC1G9Oow6kxiUP5h96IkucWlTSNQ/856OdS7a6AWh/RODz1D5BV12bYHpGJcT5eA+c2Q890xSRflkP2VVoKawnIkV3KnydJQ4upY8W7Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379836; c=relaxed/simple;
	bh=9J9OFdXdPOzqRg46v9c6LLx/wmCHcO1mBidBFDn7LOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6J/FQxYko4tvo5G9SkyroMsmDgnCBUDsukw0JpL6ChZuYIvLAmXKEkV1bacj6T/yDXv+qoVdAeXc7/CK8a2kRhpLcVmgFn3YjOhK0GPudImy6/OUaoORsznBpuZr4uAhsge0Z7ZctcgeXzrqQwqJF8QqWa4AqzrAZbu4OscCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVbu85cy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVbu85cy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso260865e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jul 2026 19:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785379833; x=1785984633; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y0Z2dn9fAv9gkJzeyjQZG7zv4uXVocGs2xKCzgJLZsk=;
        b=gVbu85cyz+nu9mV1wxCxfp6YdF6TLtz/bLfcn4THW1m45bLTVYxVR2ppWO/UJaMGZ4
         +7QnbzxG0CSe/XxB52WNaMKi4Go0B1PAqNOa1U7vzQYa5QugascgR5IxfpU8Ldst0Ur7
         LSdPyX9Xj6zXNG+CIPYDezq+WXxE3fDBg8+0NZMjGZAvfkTxJBc9rFU6tK9PHDek/iyv
         Us0md9UCproLts5CgNhEGCb6BDhMBuEM9oDMdpBoasgV3Qn0sw09UYKxdMuL2CxkPRDs
         LnNGt5M/UAmxOtwS1vcdjZttZ11PNF95zsdbPKsbxVcDlDR5wDAYQcXJyi3Q/JQqLEPc
         wW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785379833; x=1785984633;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0Z2dn9fAv9gkJzeyjQZG7zv4uXVocGs2xKCzgJLZsk=;
        b=I1o8h9WeYUybPNiYZhUEh3CC0YYvY+ja8SPeJjBZ1Jeig4SzmRt6MeROIIoPjY+xzB
         NsCfy1hvudSpSJny9Ti3vvPZrHOWzUJioxPlZrhf0D78KswfOXVmZQf5yEKXYuZg7yfG
         gLoy70SqPSFAxB7pSyVp5R16ZpQrJAah3uk27FtgthUgDLeLiMBrz6VofkQ4pcWvcRen
         Vg72I9sfdvWquLimOIgbxxJqVtUWN1iEJyi0NcPPKe8yz62/pDyfhoshjWxntwvCax7q
         IXUKOmvJ9MBsdK78fLBqGVAaDOn6mDuYiZL4MK4xvDXd1t0i5x87LJmUskcvqr0tup5m
         l12g==
X-Forwarded-Encrypted: i=1; AHgh+RpaNo8q7fcrypv+zX8Utbb63npNKLdx75w+YYNsxduvihEBupUoeaNeG3YY2w3fweu98VZUvgnxRzpog0K8+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQq0JPWTEXk1povCObIPLm1ulQsA61oU/GwhD6E+VMv+9+pym+
	6wyUGkPg+oiLKvcHehEeOjwm9FiAONnqShnSvDgEMdquwB1J7eHhT3Tx
X-Gm-Gg: AR+sD13SUhZ+Ak3BnF4HY/VB6KJpkStE88eeLbO93LpdPnM2KwsjB9aMUSR8BwGOL/j
	GWC6KMLP/2mbKRbHmEV3gpqcqr+L48LQMY5r4IvcP0n3hqbysb4VDaWtFnllh4DNS92w9m8WL+A
	t2WG+n/jWf9nzGSNcR1XrBveogBi3OdgX9DYq0cv2+sCOa0xNK6YcHBBl7Ya7NzBFqd9Tcw3CkW
	RsIxxWyDzp87mEERhBX46DVsDrrnLlVsN3VMcHc8Y5NVyKJxOn3pwW9y8EobhSorL3JCFsACJ7I
	99khej1dUVoicHiuov4C91Jmu5cokLD7OnCUUBk8vzDyVFL2SUZMLd0lB9nxNkt7H9H9YuOivJ2
	cUL/uDpYLhfhsBrYhc0uSAKD9zf7ZZmLXk2omJxXqZell+pxUo6DgFQ98LJVjHD04ILMVB4tvf3
	7ZDz4W7adPRNpTfHSfDbA+TnP18809lM45Yw4fRLRLBCRIJEjwMM7ybPhIeCa4I/uo/qBKAwBS
X-Received: by 2002:a05:600c:4ece:b0:496:c379:b2a1 with SMTP id 5b1f17b1804b1-49800e6d4d9mr8223365e9.2.1785379833057;
        Wed, 29 Jul 2026 19:50:33 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49801215764sm18030335e9.14.2026.07.29.19.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 19:50:31 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: ruipengqi3@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	bigeasy@linutronix.de
Cc: lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	zhouyuhang@kylinos.cn,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	ebiggers@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: Re: [PATCH 1/2] hung_task: show the blocker task if the task is hung on rtmutex
Date: Thu, 30 Jul 2026 10:50:18 +0800
Message-ID: <20260730024448.418327-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4dd13bdf76de6ce1e4d825af9f393a5dd59f25e8.1785376929.git.ruipengqi3@gmail.com>
References: <cover.1785376929.git.ruipengqi3@gmail.com>
 <4dd13bdf76de6ce1e4d825af9f393a5dd59f25e8.1785376929.git.ruipengqi3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Zhan Xusheng <zhanxusheng1024@gmail.com>=0D

Hi Ruipeng,=0D
=0D
Nice extension.  I traced the set/clear pairing and it looks sound: the=0D
blocker is set/cleared alongside every task->pi_blocked_on assignment (all=
=0D
three pi_blocked_on =3D NULL sites clear it), so there is no stale blocker=
=0D
left behind.  Gating the mutex/rwsem cases in debug_show_blocker() under=0D
!CONFIG_PREEMPT_RT also matches that their setters (and mutex_get_owner()/=
=0D
rwsem_owner()) only exist on !RT, while BLOCKER_TYPE_SEM is correctly kept=
=0D
since semaphores stay counting on RT.  A few comments:=0D
=0D
> +extern void debug_trace_blocker(struct task_struct *task,=0D
> +	       unsigned long timeout, bool iter);=0D
[...]=0D
> +static inline void debug_trace_blocker(struct task_struct *task,=0D
> +	      unsigned long timeout, bool iter)=0D
> +{=0D
> +}=0D
=0D
debug_trace_blocker() seems to be only declared (and stubbed) here - I=0D
can't find any definition or caller in the series or in-tree.  Is it a=0D
leftover from a larger WIP that should be dropped?=0D
=0D
> +#ifdef CONFIG_64BIT=0D
> +#define BLOCKER_TYPE_RTMUTEX		0x04UL=0D
> +#define BLOCKER_TYPE_MASK		0x07UL=0D
> +#else=0D
> #define BLOCKER_TYPE_MASK		0x03UL=0D
> +#endif=0D
=0D
Since the 3rd bit is only available on 64-bit, rtmutex blocker tracking is=
=0D
effectively 64-bit only (on 32-bit the two low bits are already taken by=0D
mutex/sem/rwsem-r/w).  Could the changelog state that explicitly?  Also,=0D
on PREEMPT_RT spinlock_t/rwlock_t/mutex/rwsem are all rtmutex-based, so=0D
this effectively reports every rtmutex-based sleeping-lock wait, not only=0D
rt_mutex_lock() - a word about that would keep the "blocked on a rtmutex"=0D
line from being surprising for what was a mutex/spinlock at the source=0D
level.=0D
=0D
> +#if defined(CONFIG_64BIT)=0D
> +	hung_task_set_blocker(task, lock, BLOCKER_TYPE_RTMUTEX);=0D
> +#endif=0D
=0D
(and the three matching clear sites)=0D
=0D
Would it be cleaner to hide the CONFIG_64BIT-ness inside the hung_task=0D
helpers - e.g. a no-op rtmutex set/clear on 32-bit - so rtmutex.c doesn't=0D
need the scattered #if at each call site?=0D
=0D
Thanks,=0D
Zhan Xusheng=0D
