Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9060D27BF7C
	for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098718; cv=none; b=gqpFrzNAUPA3TCdliq3U4b8uGRUgj3cRUfL70m0w7Ul49gwCUafIh4Qk5aNzcEMrhE8I0091JOn2F5nBQtOpYrF/kvfxWp6Jvi+TdTgFluiD6LIP4WMx+sIsvmAC2WUWCAHuS/sgajc9DQUWpk6B8YTY9TGX7XUAJ2wUJs1OkXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098718; c=relaxed/simple;
	bh=qCFQQ2oojsPDFgKwrMlLcnMkmKkEahveakHU+wx0EvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fENPJamj8QSBUU7VeKCw1qu+7FbgH1zPYGJCB04oWqfVlI5yxN3nFQMz9VYpOZzxT5hHXBI+u2Lkp+MSRdGJ7xY7bICeP7lY8pGrsAxLT0azq1UjGreJCvWlS3Ior/baXZYuuuJlMWa/Yw5iNWiAeF5iyrBiu3O5xX7vaS9h3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIWmDRW4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lccC5GJs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIWmDRW4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lccC5GJs"
Date: Wed, 15 Jul 2026 08:58:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784098714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0mol56OeFOLoPE50aRHGw+ca2VnBERRt74M97RUREk=;
	b=TIWmDRW4FGasjDIy7WqLSusYTjUObf4nRjqHBNfsaWJvbQo272KaYPw6NTNO3CvIewl5kp
	OIZ/qbV6lElnpU2I+0u/Pr/WmkyieoAmMWNL8OzxftlfKFq9Vj4Y2oQN2Y4piyRAOdmUmK
	LCy5UvMcooQkqqiOYOcyFiwEyvjyOYNclPYc1WHCFiMC0EF9XwOAphI0AkJBcIwmDDF5ar
	I7OmdRt8AJVJAMjenWkiOxMUHE+fzx6Dt2xQr6L9WtuCou/fAtgu9W3ESgaFQ4WZyiowRF
	9oh5hfcE2+KU//adKJkkUa+L7SmJ4Z0l39DFAkLPBqOverJfirSzYXHgsq2XQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784098714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0mol56OeFOLoPE50aRHGw+ca2VnBERRt74M97RUREk=;
	b=lccC5GJsOFnqIHdkjERveWjvsMWe+8tdazhZB/+RL2ukRNuhHNJUSATmuBFVM5R5Pcgn9G
	6kQWqDTrtGwYuhBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: MOHAMED AYMAN <mohamedaymanworkspace@gmail.com>
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
Message-ID: <20260715065832.qI7c2Px5@linutronix.de>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260713230028.8046-1-mohamedaymanworkspace@gmail.com>
 <20260714104252.NuPnAQyJ@linutronix.de>
 <CABWZVho1=oJHU6U16Kc-Nh1bQbn07oz7PPkM9Diy=JS0beGjFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABWZVho1=oJHU6U16Kc-Nh1bQbn07oz7PPkM9Diy=JS0beGjFQ@mail.gmail.com>

On 2026-07-14 22:42:12 [+0300], MOHAMED AYMAN wrote:
> Hi Sebastian,
Hi Mohamed,

> Thank you for the review and the feedback.
> 
> Regarding the commit message:
> You are completely right. I will update the wording in the v4 patch to
> explicitly state that it "uses a spinlock_t for locking which becomes
> a sleeping lock on PREEMPT_RT" instead of calling it an rt_mutex
> directly.
> 
> Regarding the module-ref counter:
> We don't explicitly bump the module reference count for each new
> device. Instead, we rely on `destroy_workqueue(coresight_wq)` inside
> `coresight_exit()`. `destroy_workqueue()` synchronously drains all
> pending work items before returning, which ensures no deferred puts
> are executed after the module is unmapped.

But what stops the module unload before all devices are released?

> Regarding deferring coresight_device_release() vs put_device():
> My initial v1 patch did exactly what you suggested, it only deferred
> the body of `coresight_device_release()`. However, it was pointed out
> that `put_device()` synchronously recurses into `kobject_cleanup()`,
> which invokes the child's release function and immediately afterwards
> calls `kobject_put(parent)`.
> 
> If we only defer the child's release callback, the `put_device()` call
> itself will still execute in the atomic CPU_PM notifier context. If
> the parent device's release path acquires any sleeping locks, we will
> still hit a "scheduling while atomic" panic. Deferring `put_device()`
> entirely protects against this parent cascade.
> 
> If it is strictly guaranteed that Coresight parent devices (liike
> AMBA) will never sleep during their release paths, I can happily
> revert to the simpler approach of just deferring
> `coresight_device_release()`.
> 
> Would you prefer I revert to deferring just the release function, or
> keep the current architecture to safeguard the parent put?

Well deferring as I suggested if the kobj goes away is a not good.
That I part I didn't get: You have the call chain:
|  coresight_cpu_pm_notify() (IRQs off)
|    -> coresight_put_percpu_source_ref()
|      -> put_device()
|        -> coresight_device_release()
|          -> free_percpu()


What you skipped is coresight_cpu_get_active_path() and this one has a
get and a put. Your put has a irqlock on coresight_dev_lock which I am
not sure you need. But more importantly, why is the reference going back
to 0? There would have to be a coresight_clear_percpu_source() in
between, right?

If you could avoid grabbing a reference in the coresight_cpu_pm_notify()
path then we wouldn't have that problem or is there more to it?

> Best regards,,
> Mohamed Ayman

Sebastian
