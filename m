Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F51799F
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Feb 2026 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950427; cv=none; b=al4K3+qWzN2JuFpohxzkwXr7GFGR0OepLOuMrU5ApgZuqir4X3BGqBwYHqSagQJXeA5dlcFoCnlqBF8OExMXKzoUYhkDOYHAWBz+VuuiFmewhwedlEntVLtRU7fTfw9RfDMgAqhQTiBAqlXVC6SQsG+nMBRXs2Ne39z19aQ3nm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950427; c=relaxed/simple;
	bh=uCj49cID3Uc8gmeV44f4pe9l3M4OudsHfhPus5MABR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLGQSTfcyjz2cEPUUWqvsbG6gezYfhGryamV5wTWVZXXJt6TjXsx5qOEfCVhjoVt8XYxcq10HNDAOJ83T/xuEjwCMrLjXL6sCyQrZqE/+FOKkUB5KefgMCDSHO8o46tpKBrez0QLeOPmhdIws+3UzuoK2AxPTlq2Rjmu7FYmrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cfiQt0He; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=66Bbl3q0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cfiQt0He";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="66Bbl3q0"
Date: Tue, 24 Feb 2026 17:27:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771950424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An2SQY23Mr6grh1u+6lgyPcn0Zz3R+IhJ6v+DJueH1Q=;
	b=cfiQt0He8yYtaUTvGLsnMwDTKjcxz2M15npsQrismFviaM2Zr2aGwgYfS2x3dugsgtvNzw
	85zy0TZTbM5wsuy6+mwyPn8EIxpHRQkJtifJR4lqdu6htkTOpuFkmE6gmO8PqiC4jiXAdl
	K1vt8D+0Dri9FetxquT+xkOLXYqqvh+Gnqh4Ptt5kWONxCLoFbSHDRYJbvFZdoI83F9Ea3
	lvrqJmKHOdqttkEQk0rgLVgU0K3GazpxePyLYVKzJ6sDv7OVRgBIJsJjYs3H25ORmI6mz8
	hL+U1pU0dXpzaX0aHhajkSFTdCiPwNHTIZzVsWaPq2cXpZ0+TYDYPbJMYRwAWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771950424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An2SQY23Mr6grh1u+6lgyPcn0Zz3R+IhJ6v+DJueH1Q=;
	b=66Bbl3q008upA/iOrHg032B+K6rOfOyFXHc0FRThzHwlVEik9P3aWvxJCzirbZ67pCTLox
	w3hzNXhtyJ/t/+Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [i915-rt v6 00/24] drm/i915/display: All patches to make
 PREEMPT_RT work on i915 + xe.
Message-ID: <20260224162703.Q_taYjEC@linutronix.de>
References: <20260220083657.28815-26-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260220083657.28815-26-dev@lankhorst.se>

On 2026-02-20 09:36:58 [+0100], Maarten Lankhorst wrote:
> New version, new approach!
>=20
> A lot of the problems with PREEMPT_RT happen because of the current vblank
> handling. The real solution is making it more deterministic.
>=20
=E2=80=A6

I applied this on top of drm-tip because nothing else I had around
applied cleanly. I had to tell the selftests to use
dma_fence_lock_irqsave() instead of spin_lock_irq() but I guess you are
aware of it.
I've been using it a bit and haven't noticed any big spikes while doing
this and that. The help message for CONFIG_DRM_I915_SELFTEST refers to
i915.selftest but this seems to have been replaced by
{mock|live|perf}_selftests. Using mock_selftest I get

| i915: Running i915_sw_fence_mock_selftests/test_timer
| BUG: sleeping function called from invalid context at kernel/locking/spin=
lock_rt.c:48
| in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4667, name: modpro=
be
| preempt_count: 1, expected: 0
| RCU nest depth: 0, expected: 0
| 1 lock held by modprobe/4667:
|  #0: ffffd06703d0ba58 (&tf->fence/1){+.+.}-{2:2}, at: __i915_sw_fence_wak=
e_up_all+0x122/0x1d0 [i915]
| Preemption disabled at:
| [<ffffffffc1a1990e>] test_timer+0x2e/0x230 [i915]
^
| CPU: 2 UID: 0 PID: 4667 Comm: modprobe Tainted: G     U              7.0.=
0-rc1+ #1 PREEMPT_{RT,(lazy)}
| Tainted: [U]=3DUSER
| Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./Z68 Pro3-M, =
BIOS P2.30 06/29/2012
| Call Trace:
|  <TASK>
|  dump_stack_lvl+0x68/0x90
|  __might_resched.cold+0xf0/0x12b
|  rt_spin_lock_nested+0x5d/0x200
|  __i915_sw_fence_wake_up_all+0x122/0x1d0 [i915]
|  i915_sw_fence_complete+0x3e/0x60 [i915]
|  test_timer+0x42/0x230 [i915]
^ has a preempt_disable()

|  __i915_subtests.cold+0x22/0x71 [i915]
|  __run_selftests.cold+0x89/0xb8 [i915]
|  i915_mock_selftests+0x30/0x70 [i915]
|  i915_init+0x22/0x80 [i915]
|
| i915: Running i915_sw_fence_mock_selftests/test_dma_fence
| Asynchronous wait on fence mock:mock:0 timed out (hint:fence_notify [i915=
])
| BUG: sleeping function called from invalid context at kernel/locking/spin=
lock_rt.c:48
| in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 86, name: ktimers/7
| preempt_count: 0, expected: 0
| RCU nest depth: 2, expected: 2
| 6 locks held by ktimers/7/86:
|  #0: ffffffff8f881700 (local_bh){.+.+}-{1:2}, at: __local_bh_disable_ip+0=
x23/0x230
|  #1: ffffffff8f909440 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable=
_ip+0x124/0x230
|  #2: ffff8acf9751fce0 (&base->expiry_lock){+...}-{2:2}, at: timer_expire_=
remote+0x37/0x60
|  #3: ffffffff8f909440 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0xf6/=
0x200
|  #4: ffffd0670031fc58 ((&timer->timer)){....}-{0:0}, at: call_timer_fn+0x=
7e/0x280
|  #5: ffff8acf857eb7d8 (fence/1){+.+.}-{2:2}, at: __i915_sw_fence_wake_up_=
all+0x122/0x1d0 [i915]
| irq event stamp: 729273
| hardirqs last  enabled at (729272): [<ffffffff8f0df4dc>] _raw_spin_unlock=
_irqrestore+0x4c/0x70
| hardirqs last disabled at (729273): [<ffffffff8f0df162>] _raw_spin_lock_i=
rq+0x52/0x60

I guess this could be improved=E2=80=A6

| softirqs last  enabled at (729252): [<ffffffff8e50da42>] run_ktimerd+0x72=
/0xb0
| softirqs last disabled at (729256): [<ffffffff8e50d9db>] run_ktimerd+0xb/=
0xb0
| CPU: 7 UID: 0 PID: 86 Comm: ktimers/7 Tainted: G     U  W           7.0.0=
-rc1+ #1 PREEMPT_{RT,(lazy)}
| Tainted: [U]=3DUSER, [W]=3DWARN
| Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./Z68 Pro3-M, =
BIOS P2.30 06/29/2012
| Call Trace:
|  <TASK>
|  dump_stack_lvl+0x68/0x90
|  __might_resched.cold+0xf0/0x12b
|  rt_spin_lock_nested+0x5d/0x200
|  __i915_sw_fence_wake_up_all+0x122/0x1d0 [i915]
|  i915_sw_fence_complete+0x3e/0x60 [i915]
|  call_timer_fn+0xaa/0x280
|  __run_timers+0x1e8/0x340
|  timer_expire_remote+0x47/0x60
|  tmigr_handle_remote+0x381/0x500
|  handle_softirqs.isra.0+0xc0/0x3f0
|  run_ktimerd+0x50/0xb0
|  smpboot_thread_fn+0x12d/0x2e0
| i915: Running scatterlist
| i915: Running scatterlist_mock_selftests/igt_sg_alloc
| sg_alloc_table timed out
| i915: Running scatterlist_mock_selftests/igt_sg_trim
| i915_sg_trim timed out
=E2=80=A6

There is nothing else, that popped up. So far no objections from my side
;) Thank you.

Sebastian
