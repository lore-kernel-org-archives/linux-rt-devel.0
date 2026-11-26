Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656947;
	b=ziyVun3iE+Vd10R7hbB93RMDYvGKe3s2LBNr1+zh0v8AYbsuAx6brLXGkaa2s/IASmuH
	 UmiQKWHZNucq5ARlhnMk0MWjlL1r3rVvuG9FWqJy8F/kSNkdGFCI4HmKeK/IyrLcgFqnr
	 inFYB6XkYYzBHbgGHsyFgrZ8wD4GA2Oy6a759hAdC1m/P/+fMH4cAjkYTh/WedEsSe4Zx
	 u0ou8gh8XmmT+qErJ7vVYYreaVLJEOVwwnIlIXDWSKy90TnAf0fCDowfu8ePB6FUP1hnh
	 XR2hwOSt+4TDMDEGknrttJNFXUKhN0Bg/ErKyVdwOVMf/cwUOKUyARkc1KEPpEEn48Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656947;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KlCKwLKEIcdcb9Z/f+8gfIqoz04BE7KsEMO27vlUrI4=;
	b=t7AJS78X9uQGrsI+YoVD7TaJOsRgZMmcgob5+ta0bmbchFq5fZnxOov30PuI5XtYDHB/
	 poTM6x0leI+nKttVjsxFWjY/MdVBvjH83eJPONvilVemw0YmEyCCfn/dlEdpS/1C6QZ5c
	 Q/EvwF6ZMTlrMdW1zcMZdGGssOb+Kbjsqc/88nJS2cn+yHwuVaOor8K8Lu4zCp0I8gISY
	 uuv4kfPJ5WPTajs3sK4k0uwsVNNrP+qlkKfJSYiUw/tfnqyETPzwn2W/B0vC7i3J4t8WX
	 Xa9IPbIoSUAzoV+vdWsV7xFlvbxZQd5zefFewsO0vee4jRMsWOtC3A2sXhGIMf+KtKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYfy5cax;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1A606A321;
	Thu, 26 Nov 2026 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYfy5cax
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D34B1F000CA;
	Thu, 26 Nov 2026 01:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795656946;
	bh=KlCKwLKEIcdcb9Z/f+8gfIqoz04BE7KsEMO27vlUrI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XYfy5caxq3RMNo1qeo42I+ipEYGFPTHFY7Gwp0AoIicX40avZUdTc8Q+vdEo/FGYp
	 KI5cMldPRejYL3GbC/JbpKzJcI24AbKn3CQFJiPQB6TSeOHoy0ZyMkeUFSVTEdBcpn
	 +BAc6rZzWf0lpXJOqLDGJ/bHvQYECvN6YxelIYAN+F02G9RTV25MqexeeF/HdwL3H9
	 s7S+Mmuh78tfYrwigWIimmNqF3/tkALhjae6pqmo1ggyD4gP4akB7Aw6FuU1KwkyUY
	 9IW4R6dQNre4WFOhHneXKl1um1EUTvmyQ4hhxUFNoyslbxuZM0ROhuGJDnZSK7857G
	 yZt92/mTduVwA==
Message-ID: <sashiko-outbox-234565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 25/43] sched/deadline: Count the 0-lag time from the
 next period
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <1d535c0c45a21d94ebadfce2883ce8d8b6789c44.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <1d535c0c45a21d94ebadfce2883ce8d8b6789c44.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 01:35:46 +0000
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
- [Medium] sched/deadline: dl_time_to_zerolag() miscomputes 0-lag when
  deadline is 0
--

commit 03d5dc8d2f6d0b382a7bed954bd1379667e09042
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Count the 0-lag time from the next period

This commit computes a deadline entity's 0-lag time relative to
dl_next_period(dl_se) rather than dl_se->deadline so that tasks with
constrained deadlines do not reach their 0-lag time prematurely.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 74b3c6b967eee..1d2dcf478f95d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -633,12 +637,12 @@ static unsigned int dl_task_root_domain_cpu(struct =
task_struct *p);
>   */
>  static s64 dl_time_to_zerolag(struct sched_dl_entity *dl_se, struct rq *=
rq)
>  {
> -	/* Time to the deadline. Negative if the deadline has passed. */
> -	s64 left =3D dl_se->deadline - rq_clock(rq);
> +	/* Time to the next period. Negative if it has started. */
> +	s64 left =3D dl_next_period(dl_se) - rq_clock(rq);

[Severity: Medium]
Can dl_time_to_zerolag() return a positive delay when dl_se->deadline is 0?

If a sleeping task with no active period (dl_se->deadline =3D=3D 0 and
dl_se->runtime =3D=3D 0) is switched into SCHED_DEADLINE with a constrained
deadline (dl_deadline < dl_period) and then switched back out while still
asleep, switched_from_dl() -> task_non_contending() calls
dl_time_to_zerolag().  Previously, dl_se->deadline - rq_clock(rq) was
negative and the bandwidth was released immediately.  With dl_next_period(),
0 - dl_deadline + dl_period evaluates to dl_period - dl_deadline; whenever
rq_clock(rq) is smaller than that difference, left is non-negative and
inactive_timer is armed, holding the task's bandwidth in root-domain
total_bw and causing subsequent admission checks to fail with -EBUSY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D25
