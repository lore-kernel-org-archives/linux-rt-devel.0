Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800678;
	b=nsCrOTsdC+XFnfah55ndV3hZLWC8xdunD6rY8a7Orq6xKz3T90uyeiu6gMSs95NPzrVM
	 sn/OVZyS4874fic5p57Od8e5BdPE0f9bKJczyyxCr3tZxru2ZMG3LHXIH+hd4roDLYYC4
	 FTRiTeyXkKxhOIavfAC6sLWz+De8/+EQ5SjeNfu/BUZmvJEnbhH9p24xokaYb+ZvIt4S1
	 WFJ6ML34AU57FlIcjTKV41mKBzQMjOvrLD2/daZztrkc9vulg0gy/AoLzdFoNy+RDefz8
	 1RUZBcVl1ky7ddHmzeG6960seCPX2CFXgipBPvqVHssEDmNRZkt5V3Cjc4F2sPxdNRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3Ix8WFsfZ7YsPR1widkTlRAvFIcyO/8QOV6pMYTjzqE=;
	b=5rfky/0UrGh9wcoXFY9wMpfEDWz3aA/By5n7GD9k5U3IIpu1QVAd5UsGKg9VaMq9dr2U
	 UU0Ctw3ndLBpfrp1TfLR2N6zaHc1iZTaoVxreLxd+miKzRW07XOHhF4+mUwnjkLvvmzN4
	 doO4DaPAD381eHu0Tg1xpuEYkLE1q7ZI2JFe2bbo8hmXFDTBXcVnugeKkwfHw55ih3Ao9
	 8OHzE9jWjt7/ZvvSW/QaYHeLJiU7KfaJm49pe2kmzqji+NyRJv8Ssd8QggdC79Al2xswi
	 YfCfs/Wb0DNnpKnZARLjxDc/MJLDtttL6tc0A9Qz9ImZvlwQuu+hRcW2CZbZTycv8gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6GimfhD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F5606A31E;
	Fri, 27 Nov 2026 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6GimfhD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865001F000C1;
	Fri, 27 Nov 2026 17:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795800677;
	bh=3Ix8WFsfZ7YsPR1widkTlRAvFIcyO/8QOV6pMYTjzqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H6GimfhD3Xtf/LWDKd0i5E+TuJXH8279onw3wlfrUanxPc38XQnhoDr67Qnv8waWp
	 LRTlZZtkcYqlI5qHYnF9uxZHueX1TyBegiYPHyaR1YlODZh+t1w0JedCApqYkNIOZ5
	 UljGo6rfW8XEKJeRreGGJkrszle80M5ikzSMGW9bbIvTsv95INywVtEByRFZ4HSoZL
	 omqT7MkyuQT75ztA13jpkAwKMIt5Ol6JDPDd9m7RD5krnvzbsPw93SbaFgxSebOk5c
	 4VSOuL/5xoIHl2pr7YlhY9I8jee8jP55AMNOJKCoQ3K19ASH+71/ZH6NkArAsTfHGA
	 Q2H+aEB+n0Xlg==
Message-ID: <sashiko-outbox-237994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 34/43] sched/deadline: Cancel the replenishment
 timer with the parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <bf332219b2e9744e536502a4eb04baa0674e4fa8.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <bf332219b2e9744e536502a4eb04baa0674e4fa8.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 17:31:17 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] sched/deadline: dl_task_timer() extends departed constrained
  task by a period
--

commit 5761a4e5c3f4329860b62244eb1a4d3665aa6ab4
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Cancel the replenishment timer with the parameters

This commit cancels dl_se->dl_timer in task_non_contending() and
inactive_task_timer() when releasing a task's bandwidth and clearing its
SCHED_DEADLINE parameters.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3eeb4c5cd924d..94d2b962208e7 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -993,6 +993,7 @@ static void task_non_contending(struct sched_dl_entit=
y *dl_se, bool dl_task)
>  				if (dl_task && READ_ONCE(p->__state) =3D=3D TASK_DEAD)
>  					sub_rq_bw(dl_se, &rq->dl);
>  				dl_task_release_bw(p);
> +				cancel_replenish_timer(dl_se);
>  				__dl_clear_params(dl_se);
>  			}
>  		}
> @@ -2932,6 +2933,7 @@ static enum hrtimer_restart inactive_task_timer(str=
uct hrtimer *timer)
>  		}
> =20
>  		dl_task_release_bw(p);
> +		cancel_replenish_timer(dl_se);
>  		__dl_clear_params(dl_se);
> =20
>  		goto unlock;

[Severity: Medium]
Can dl_task_timer() advance dl_next_period(dl_se) before cancel_replenish_t=
imer()
is reached, extending a departed constrained task's bandwidth reservation by
an extra period?

In this series, commit "sched/deadline: Count the 0-lag time from the next
period" counts the 0-lag time from dl_next_period(dl_se), and commit
"sched/deadline: Keep a departing constrained task until its next period"
keeps a non-dying departing constrained task until at least
dl_next_period(dl_se) in both task_non_contending() and
inactive_task_timer() without cancelling dl_se->dl_timer.

When a constrained task is throttled in period [0, P] (with dl_timer armed
for P) and leaves SCHED_DEADLINE before P, dl_timer fires at P before
inactive_timer (either because dl_timer was queued earlier for expiry at P,
or because an overrun placed the 0-lag time after P):

kernel/sched/deadline.c:dl_task_timer() {
	...
	if (!dl_task(p)) {
		if (dl_se->dl_throttled && !is_dl_boosted(dl_se)) {
			sched_clock_tick();
			update_rq_clock(rq);
			replenish_dl_entity(dl_se);
		}
		goto unlock;
	}
	...
}

replenish_dl_entity() advances dl_se->deadline by dl_period, moving
dl_next_period(dl_se) to 2*P.  When inactive_task_timer() (or
task_non_contending() if the task slept in SCHED_DEADLINE past P and then
left) subsequently runs, it sees dl_next_period(dl_se) - rq_clock(rq) > 0
and restarts inactive_timer for 2*P instead of reaching
dl_task_release_bw(), cancel_replenish_timer(), and __dl_clear_params().

The departed task's bandwidth stays locked in dl_b->total_bw for an extra
full period [P, 2*P], and if the task re-enters SCHED_DEADLINE in
(P + dl_deadline, 2*P) it is throttled with zero runtime until 2*P even
though it never ran in [P, 2*P].

Also, the commit message says that a constrained-deadline task that overran
by little reaches its 0-lag time before the end of its period and has its
timer cancelled at the 0-lag time, which does not match counting the 0-lag
time from dl_next_period(dl_se) and keeping departing constrained tasks
until dl_next_period(dl_se).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D34
