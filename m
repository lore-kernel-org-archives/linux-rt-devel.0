Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFC2E03EB
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Sep 2025 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885886; cv=none; b=B5aaJ3cePV1KANeI17RM9hbBIMP8huNGb/UNr/KFn2kKVAV9M28zns+8S+9nJuWl+nITEcbEb5TOPGgAaUbZMjJVlzmFN9//mdh8tP7DT7ZUocvOAl4e2x+G02hZt6QayYSM/GiwwcFyuPF3VWuuCXmtNaesthOCAuQrbO8fqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885886; c=relaxed/simple;
	bh=Y0q0fONd4lqXADhnM4Y10plGfPCzTrgC7f6K8GHH+4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXA2srF5nnQroboAjeQLngjLVDi64FdDaHtbSqk7mgGmjFZpYvJRQwbBvKah2dGFEuTq217tgyAGV9kCOmIIfj6wZj7QJxOZiJcLufYbDsWvaigEZQbCBNFXlq2ElBl4Z+68Izq69X/XJA+61P2HBb8cYL/n36oeiwW1LzGDchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fD3F46nE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fD3F46nE"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7f7381bd1fcso258824785a.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 03 Sep 2025 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756885884; x=1757490684; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0q0fONd4lqXADhnM4Y10plGfPCzTrgC7f6K8GHH+4o=;
        b=fD3F46nEFOYuC3/5k9WfRwnVuvgNVW2T95Il7bE67Vyj85PzOhmnuacDZMeHxNd9w/
         wmqUWTr9rOuh77Is7YQwjnrqTV/O74TajfspJemWVvC+YeuXwksvbYswv1bzmBWztPYb
         2IPQ2L8jmIUhBrqEc9jazHOM8gVMaAQxHZM+Cws8KWL0lBwcyQeEcJz00NI7chJaNPWw
         zH9fnUDp41Th00nkBjyBgy5yG2QWbQKA8qSCqAQJIMoUSTjEwkfdQB+VlMhiRFYwHfqo
         j94Z7hY/f9Vnm4HGpzFf8ksABTKSzxHgSr/zZAZ6s6bLoQN3XeLPevsxu2FKdrtYKFMF
         Hdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756885884; x=1757490684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0q0fONd4lqXADhnM4Y10plGfPCzTrgC7f6K8GHH+4o=;
        b=Wwb1LcvBTKAtJ6HJ6DIKIJtk50ZiedJZv7pKZFG33QPvRCpqBF2odY+/oxirTEiW2D
         hBysUIdkcM6tcBEWPFxPvBUmT+fMnqVT7zl3kpAPr5RlrtkCX7zTbWdTiB/lkfGNQAJ3
         wimLFkFsMaQvV6m3fdObUPYcFxN8BSECzLfAFBEKHGtchJz5cntBhplR9OWysjd6rKTt
         TZHgWVNHOilHpv4YcqQD95ULMeDrEKSEYH/fkZB53G5HJr4IGfUrdpay6xE8t67YrpLb
         +BCHU8KiKJYl58eM7BgxDqJaW9sw586Qn5Z+nTgYQPyIPgIN478v3pAiXWMEBq3h6sgt
         sMag==
X-Gm-Message-State: AOJu0Yyy+a+0OROHdxFUEaP0BZWW8ftnamtpPJR/0KT0F9ndnGlmxyZl
	+NmfnZ1vf7Ovb+7SpWWquRwje1HQjHUJXirFqsRI++YmPyOvxh9MS5KJ89g9yKOzt8HMSFrr31e
	yUbVR089JEvNBB9OTDM98iEcRRNtW80Ee96dOr34=
X-Gm-Gg: ASbGnctztmJvKu+MTg+HkM+5VLdmwMU5cJQ095NgWg4EeEzcYk/oP5VdLuFYEu8IQb/
	gigKz83uoJo6cjiSxIux/TIfpQjPDCydyyEPfplCypet4UzCe670HrT0oSJ9+qLI569XOFKHylF
	s/jdzdA0s28xOVi7yRCfeZG4bu4WYos3qv0aS7kneE4hZRkQJrfucOovJ/8I84fWTUWrzhGN+p+
	LgbKm0UFpQk3YrCR0N4zhc7ohmCL+K94RWATAgQtSY+Nr+qD6+JHVbdHsfrnx8n1jUU/zL4Lg7z
	eC21f3Q=
X-Google-Smtp-Source: AGHT+IEqNirH6vnwrl45TL8m5PwLZsCvxgQzO3JS6HhkTWqWtA8GP+qDAQbgFGcl8U4L7If7ena+psWtw7l4ahcanrc=
X-Received: by 2002:a05:620a:3704:b0:7fa:aea2:24f8 with SMTP id
 af79cd13be357-7ff27b2249fmr1730675385a.23.1756885883986; Wed, 03 Sep 2025
 00:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250901163811.963326-1-bigeasy@linutronix.de>
 <20250901163811.963326-2-bigeasy@linutronix.de> <CAJhGHyBaqn_HOoHX+YinKW5YSy1rncfbvYXktkEtmFgK44E9wg@mail.gmail.com>
 <20250902111740.hwMmUu4T@linutronix.de> <CAJhGHyD7x9QLJ+uoRnbh4qOhphdxJU4c384D1Ph2tn5ktR_=kw@mail.gmail.com>
 <20250902155634.enTifVKX@linutronix.de>
In-Reply-To: <20250902155634.enTifVKX@linutronix.de>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 3 Sep 2025 15:51:12 +0800
X-Gm-Features: Ac12FXxWehpghM_pE5-NdHiYQXidnzDtI6Lr5vtrO0rP3JX776WmpjHyFdBBDhk
Message-ID: <CAJhGHyD3XQoxHph4pqTXjJQYovCsfvzCrg2UJ_G9v6MFGrQ77A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] workqueue: Provide a handshake for canceling BH workers
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Clark Williams <clrkwllms@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 11:56=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:

>
> That interface is actually implementing that boosting for users which
> don't use it directly. By "it" I mean the proper rtmutex.
>
> This is used by the PI/ futex code where a rtmutex is created as a
> substitute for the lock that is held by the user in userland. The lock
> is acquired in userland without kernel's doing. So in case of contention
> the user goes to kernel and creates a rtmutex as a representation of the
> userland lock in the kernel and assign it to the task that is holding
> the userland lock. Now you can block on the lock and userland tasks is
> forced to go to the kernel for unlocking.
>
> For RCU, as far as I remember, a task within an RCU can get preempted
> and in that case it adds itself to a list during schedule() so it can be
> identified later on. There can be more than one task which is preempted
> within a RCU section and so block a GP. The boost mutex is assigned to
> the first task currently blocking the GP and then next one if needed.
> A poor substitute would be something like taking a lock during
> schedule() and having a list of all those locks in case boosting is
> needed so it be acquired one by one.
>


Well explained why a =E2=80=9Cproxy=E2=80=9D lock is needed in these two ca=
ses =E2=80=94 thanks a lot.


>
> Right. So you would avoid taking the cb_lock in bh_worker(). Instead you
> would need to assign the "acquired" lock to the bh_work() task in
> __flush_work() and then block on that lock in __flush_work(). In order
> to figure out which task it is, you need some bookkeeping for it. And a
> lock to synchronise adding/ removing tasks on that list (bookkeeping) as
> well as accessing the lock itself in case of "contention".
> So given all this, that approach looks slightly more complicated. You
> would avoid the need to acquire the lock in bh_worker() but you would
> also substitute it with bookkeeping and its locking elsewhere. So I am
> not sure it is worth it.
>
> On !RT you can have only one running softirq at a time. On RT with the
> removal of the lock in local_bh_disable() (patch #3) there can be
> multiple softirqs instances in parallel on the same CPU. The primary
> goal is avoid center bottleneck and make it possible to have one NIC
> doing throughput and another NIC doing low latency packets and allowing
> the low latency NIC preempt the throughput NIC in the middle of sending/
> receiving packets instead of waiting for NAPI doing a handover.
>

The bookkeeping isn=E2=80=99t necessarily complicated. For bh_worker() on
PREEMPT_RT, it could be done in worker_leave_idle(worker) with
pool->lock already held. worker->task could be repurposed to record
the task running bh_worker(), which I think would also be useful for
debugging even on !RT.

That said, since a proxy lock isn=E2=80=99t appropriate here, let=E2=80=99s=
 just leave it aside.
