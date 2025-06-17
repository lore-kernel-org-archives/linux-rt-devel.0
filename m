Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB23208
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Jun 2025 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146740; cv=none; b=DFKVYY9GKaQitR5AnrZIisrYT43EY5M4mhaDocXqZ9ybfLgLaX6z1hG3fwpkbgeBVHGEOToeditJ/evIloOmau9Vo0yS5MVwUrzTFSMy/yUj/Sbq/v8QczdNZ7lE5gXnm4Iqhsl6IneCM1PcIi4Xh3ySnhwCDu4MNOGPOJ4nQ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146740; c=relaxed/simple;
	bh=X/iCBnwMhCfi7aLPZ/bnaMCtPAyfxWj6HxhFinOL6zc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XWLEE+TguQh7tPWv0tqU2Mkv9ahsJVsATdYDGFYh6zpUgl247Ia9k9C9vak8fzUpciE/PvkHjJ6uIdk3ryDoUSP0OxUuifID+izfMRNUyPhwKFdxjevrLjaetTkqUql0cbsvKZnWFFkiNemwqV2LHWfTSW0UPgXUQ4pUdDufnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuTeQD2A; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuTeQD2A"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e5e6ab7b8so47057977b3.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 17 Jun 2025 00:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750146738; x=1750751538; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X/iCBnwMhCfi7aLPZ/bnaMCtPAyfxWj6HxhFinOL6zc=;
        b=AuTeQD2APi6lR88H6fYPlR5nwCcO1TX0jNtY3lH7Ts76iUJDSI3/Eo1sYW5nCHe1bQ
         RzDtl/P8yvGNgDoIe1F+ZudY14V2K+2UXfR3DPVFPbRX4Xh21Sm8LqVC9aA5W/UdsOlp
         MF7GbPnilXGX6IFjkgoaDxQRAXImFrwFopOKq9ij9Ruw52qzxHVPkmK/LLMKW1lXAmdK
         v0d0txx4oBliuaxNpiChNK5ziz9xiHrz9Ifdx2LyASojnvxpUXfjRrUoNYLBxlJgpMIs
         kW9EqD74p/ZSkeAThbFqCQynraf/ua7i7pgBrzZTzjogFGcjHcSTeH+Y1Yj+XmwlyaGX
         ompw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750146738; x=1750751538;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X/iCBnwMhCfi7aLPZ/bnaMCtPAyfxWj6HxhFinOL6zc=;
        b=wo1rNuFOYhbex6DO8sLd1CBSuUehisv5cbc0cQeEv+AdJ1MfajgX+99D/th3pcp70D
         LLuqU2xQydmq2foWPOUsaHdfvE/BOaVhEOsNnPY3PbCs/p9/XfXn+thLOgp96NtEoMCD
         5K7PLKl8pKrDAaA0plrlNKWntX/618ibwJaGDIfAny+1j52DcfoRpt8MuSpCEJ2gkjNj
         YM09xevUe+9dnctpjcznTIsB77vf2i4gZ6Iw7KiP0tY2MdduLMTlir93ghX8jshC0eIK
         51KEvRKqCT0m2IW+nQovEfFDRiki0kfVTBozjNOkDEzr20rQFp9H3LFcT52H5a6IgoOf
         m8EQ==
X-Gm-Message-State: AOJu0YztjA/vf/Z+OTfntqmMcceHAYua8NeqeGCOagzOLZCJv9VqThIq
	kv5O2SuR04HGjUkm+RgJE2GQaig79qPsVMDGrtD/vyYjYsS7rLPsFnOzDNlUhnlhQZJzEJ7smRX
	jZZgNe7hqaQkLTMOiw9VED5k3QVv0j5zZCxdE
X-Gm-Gg: ASbGnctmEttSlsnRNJSWtoyxyQwyu3h4JZCnIrm4BJeKJckPcVP44K8zqX0tdXRrLoD
	vpddcJQhIuZ/9cJ0+plXNE0RJLiq+yl0mdqqAU9+H68zA7lrv1K0W+nT8neU6TUu8HRYZI7yoV5
	jfWJgjuTq1NSJMVvWdoT3ZLE+8ajJJWvjMBFhR4eEo7XE=
X-Google-Smtp-Source: AGHT+IFAM5GT3eEKcQGrWdcc05FWA8qnwy1PJ6OOefeyairq92OkJPSkLh6Ril7D/DeA0QFz24AVsR5FVS4p3X5YSuw=
X-Received: by 2002:a05:690c:60c5:b0:6f9:7a3c:1fe with SMTP id
 00721157ae682-71175431bcamr173834147b3.23.1750146738130; Tue, 17 Jun 2025
 00:52:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Kegl Rohit <keglrohit@gmail.com>
Date: Tue, 17 Jun 2025 09:52:07 +0200
X-Gm-Features: AX0GCFt5foxBB1eSOjLHXSnyGiqb4a0yY3VS586mA639DWFzdsvqEp7l1dTgyTk
Message-ID: <CAMeyCbgeL-UuxiJPVy_=zLSJfWgudKAvSQVViL8=u05yty_Pyg@mail.gmail.com>
Subject: ksoftirqd priority inversion wait_event_interruptible_timeout/schedule_timeout/del_timer_sync
To: linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello!

Using 5.10.184-rt90 on arm (nxp imx6q).

A proprietary driver starts a `kthread` with `SCHED_FIFO` -98 priority.
This `kthread` waits for a completion using
`wait_event_interruptible_timeout(comp, 1000)`
and wakes up every second to perform its work. The completion itself
only fires very infrequently.

Tracing the kernel showed that `ksoftirqd` was periodically boosted to
the same `SCHED_FIFO` -98 priority.
This is caused by the `schedule_timeout` handler within
`wait_event_interruptible_timeout`.

del_timer_wait_running takes spin_lock_bh and causes the priority inversion.
This is very bad because e.g. network softirq processing happens with
very high priority for some time.

Was this issue addressed in a more recent kernel version?

----------------------------------

static long __sched
wait_for_common(struct completion *x, long timeout, int state)
{
return __wait_for_common(x, schedule_timeout, timeout, state);
}

----------------------------------

signed long __sched schedule_timeout(signed long timeout)
{
....

schedule();
del_singleshot_timer_sync(&timer.timer);
...
}

----------------------------------

#define del_singleshot_timer_sync(t) del_timer_sync(t)

----------------------------------

int del_timer_sync(struct timer_list *timer)
{
...
do {
ret = try_to_del_timer_sync(timer);

if (unlikely(ret < 0)) {
del_timer_wait_running(timer);
cpu_relax();
}
} while (ret < 0);
...
}

----------------------------------

/*
 * This function is called on PREEMPT_RT kernels when the fast path
 * deletion of a timer failed because the timer callback function was
 * running.
 *
 * This prevents priority inversion, if the softirq thread on a remote CPU
 * got preempted, and it prevents a life lock when the task which tries to
 * delete a timer preempted the softirq thread running the timer callback
 * function.
 */
static void del_timer_wait_running(struct timer_list *timer)
{
u32 tf;

tf = READ_ONCE(timer->flags);
if (!(tf & (TIMER_MIGRATING | TIMER_IRQSAFE))) {
struct timer_base *base = get_timer_base(tf);

/*
* Mark the base as contended and grab the expiry lock,
* which is held by the softirq across the timer
* callback. Drop the lock immediately so the softirq can
* expire the next timer. In theory the timer could already
* be running again, but that's more than unlikely and just
* causes another wait loop.
*/
atomic_inc(&base->timer_waiters);
spin_lock_bh(&base->expiry_lock);
atomic_dec(&base->timer_waiters);
spin_unlock_bh(&base->expiry_lock);
}
}

Thanks in advance.
