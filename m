Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83FB37268B
	for <linux-rt-devel@lists.linux.dev>; Tue, 14 Jul 2026 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025777; cv=none; b=o2ooBqh4mTeObEWnCouek7gl0GJG/BRKIei7mt7YmavionnjP+3Oif1z/eDeH0TZmhLLyR54W60M69B4n61taljPXgLfqSD+2pHH7osoEJpLRoQ63CiZS39k3nXUgUTkfUPoUnRuAkPXhAWkIfXrmlKOcAHVM8KGntZ74dwamcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025777; c=relaxed/simple;
	bh=vJ6CMvHV3MQr0Eg2aw/y8R+827fUIV/2h+7PCT6LD90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JV87fI3KFElJ+9rOLiethPn82ouxMGdKKg//kUVWIkbGnjzPxF99OcgNgsljrIiOeq2I3nxHqCN3dGgol+KpthPc5U5KfqkQ8KwcEhiWs2WwqsIY2kKcgyMr36MUko2KXtxcFsyf3Q1Oi+uyq6o9Z3TxrixVp0xoNnJzfy23JzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rciFWg67; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EE5qzirj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rciFWg67";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EE5qzirj"
Date: Tue, 14 Jul 2026 12:42:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784025774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWhYSDNYe30neXqLv4I04NFK75OYwIpjkWpiUCQMG/8=;
	b=rciFWg67IKLXxisGVGJryXKdsZJla3vgfRI4Ln5IlOg/X41onZWPfr5EJ2U+3sLMkohhXJ
	ywGrKftPeVyZ0hSCLxFXqqtzMgnq8gv90BaLuGK+tdTlCH202EAwIja6ZvNh+Jir2QJ0TQ
	u0FPdryPNMD4KFryDrWxLZur7fes8SmJUpvfFp6L4gXCDMjNGb/1c3yqNFSEpKWZFm5le8
	ORD7bgaU07yViornYeyNqt8HsBZO6Y/R86bXr+MQ742AjUcN8tyRh0MXempngtaqvqoNzE
	aB51RxLn+UQo9+1KrxonSWlrwaUgeHY9uqr5DSXgIXBI++hnJkf0Vd5WVAOnGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784025774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWhYSDNYe30neXqLv4I04NFK75OYwIpjkWpiUCQMG/8=;
	b=EE5qzirjS+z3zzcI2P+QguOR8ZRZ3W28oL0tCi3jS4bFB5RDLm1i4ZnBH5SNs4FzFAvLTz
	mXLe8yG2oMYDpECg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <coresight@lists.linaro.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v2] coresight: Fix scheduling while atomic in
 coresight_put_percpu_source_ref()
Message-ID: <20260714104252.NuPnAQyJ@linutronix.de>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260713230028.8046-1-mohamedaymanworkspace@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260713230028.8046-1-mohamedaymanworkspace@gmail.com>

On 2026-07-14 02:00:27 [+0300], Mohamed Ayman wrote:
> Dropping the last reference to a coresight_device triggers a kernel panic
> on PREEMPT_RT builds due to a "scheduling while atomic" violation.
>=20
> During CPU idle transitions, coresight_cpu_pm_notify() runs with
> interrupts disabled. It eventually calls put_device(), which can
> synchronously trigger the device's release callback and drop the parent
> device's reference. On PREEMPT_RT, free_percpu() takes a sleeping lock
> (rt-mutex), and the parent's release callback might also sleep. Sleeping

It is a spinlock_t which we refer as a sleeping lock. There is "struct
rt_mutex" which is somehow different.
I would suggest to word it like "uses a spinlock_t for locking which
becomes a sleeping lock on PREEMPT_RT".

> in this atomic PM context crashes the system.
>=20
> A previous patch tried deferring just the coresight_device_release() body,
> but this still left the synchronous put_device() call dangerously exposed
> to sleeping parent release functions.
>=20
> Fix this by entirely deferring the put_device() call to process context.
> We add a pending counter (put_pending) and a work_struct to the coresight
> device. When releasing a reference, we increment the counter and queue
> the work. A worker thread then safely drains the counter and calls
> put_device(). The counter prevents leaking references if multiple puts
> are queued before the worker even has a chance to run.
>=20
> To prevent a use-after-free race condition during module unload, the work
> is queued on a dedicated coresight_wq which is safely drained and
> destroyed in coresight_exit().

Do you have anything that keeps the module-ref counter up with each new
device?

> Finally, remove the unnecessary raw_spinlock_irqsave in the put path,
> as dropping a reference doesn't require protecting the per-CPU table.
>=20
> Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
> ---
=E2=80=A6
> @@ -163,16 +175,9 @@ void coresight_put_percpu_source_ref(struct coresigh=
t_device *csdev)
>  	if (!csdev || !coresight_is_percpu_source(csdev))
>  		return;
> =20
> -	guard(raw_spinlock_irqsave)(&coresight_dev_lock);
> +	atomic_inc(&csdev->put_pending);
> =20
> -	/*
> -	 * TODO: coresight_device_release() is invoked to release resources when
> -	 * the device's refcount reaches zero. It then calls free_percpu(),
> -	 * which acquires pcpu_lock =E2=80=94 a sleepable lock when PREEMPT_RT =
is
> -	 * enabled. Since the raw spinlock coresight_dev_lock is held, this can
> -	 * lead to a potential "scheduling while atomic" issue.
> -	 */
> -	put_device(&csdev->dev);
> +	queue_work(coresight_wq, &csdev->put_work);

What about you keep this as-is and just delay coresight_device_release()
instead?

>  }
> =20
>  struct coresight_device *coresight_get_source(struct coresight_path *pat=
h)

Sebastian
