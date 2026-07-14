Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBE44C653
	for <linux-rt-devel@lists.linux.dev>; Tue, 14 Jul 2026 19:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784058150; cv=pass; b=Jy6WnfsOtMjE/HQRWFtRCgxkcYyH7VyWfEMPo7Nl6I6/qlUFnUxQ+djx59cBM809O2eJSyTuZUHQrqHFRy/yV6qkfOV9DJyaYHt+A8xLdTrIqCly3phoPem7UyEWj/tICm5bJLYlkNRmQ5BZcTuzYainmmYV/gXWalmg5IZQUdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784058150; c=relaxed/simple;
	bh=SbaiayvY5vmasE3uDAuvIoVfPlM2nrHDRXVy4dlKWJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcDM2SBeQ222JZg4KHpJrwMbNfghas1+b0dJ/f7tGjYU3SD0Jbzb01RNEteGHfP1KvFz7R7jct52WtY5QpVaE7MVAfz7fIH0MJpYXVl9ZyVJIItNsMQmLEloI4R7bvfyk0V2b0iHa6AFYcdZd9N3l7aQBmj3QMQeAC+LK2jeb4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS3WJ1GG; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS3WJ1GG"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-44ce4d7883bso2842051fac.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 14 Jul 2026 12:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784058144; cv=none;
        d=google.com; s=arc-20260327;
        b=bMEJYip3MvJLA5ePPUNBE04Qf49ynmXK9gRxaBghxhyrkEuwsMHjiup0MEpywQ1nj/
         7woY2UiUo/NilHxlgiT3QBcwvJbY0WpjXTNy3TDAg7KHw5Bq5J4OIk35oFjNeKa0P1e7
         1+J+J+uGYxuV9ABISnD75S2oGsBu22Zp+ZsMBD8C7BsaG+m1Bxk9A41EinDetRGDZj0K
         Bz4aQIUmIVpt60BrlaVBRYlANJhWZqzGCzf0JH1BhS1QoxwdYQHjLqaSjrqA6SJ9sEkt
         Say9mCPf/j3J+gfSXqwEsvK6hANY6rugcInbsCEA2xX/khGHrcvldJOfJugmeZoJfGnQ
         V+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zxVjA6Wf03JWIhHpDHaN7R3Ti8g+kay7fZlb8zOdmF0=;
        fh=tW+FuNmbMSgitnjsRehbHYYpQb6A7Xg7/3ThoHcFPfw=;
        b=D9EAOPVC4SHZGLNQul1PpE0EbraaINZAREXHtbPyzUOMolLH/iyhSDFm4NpHmuRXQq
         jrPnYQO1BSvSStCNpUNIPhDICuZYfUnaFcaX9QX90oIj8V1itZ+rkVBOYBROJIF0y3ff
         PYBvZwku637b58X6FZd8B+4EiwIKwr4UCgW7c75nwQ+Q9YIbIe86F+av1VF9keDo2nCT
         v0OZgGC085H430Z/hY29nhwOHDZh3/5vStRyFVV8WZGAvxQKIE3mGXZ2TCdtTsrwrh42
         I5gAT3NFIblD8+tI22Y8StGzkesOenh2l5gqxdPDrTbYx7aUE/vZNONHWRbcvoks8H8X
         AOrg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784058144; x=1784662944; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zxVjA6Wf03JWIhHpDHaN7R3Ti8g+kay7fZlb8zOdmF0=;
        b=cS3WJ1GGDumcXGmuzEU7kqtHm000J7QVa3SJEnF2qnCLLfGwKk9Nc8aanGTjIJx29d
         l8n1BS2qb5ffmXpKPlEDEhJXIEBJdcbDcHWJ64fKkPpGhfAkFS9eBhgp9l8AvJCopygR
         wvfBx58wfMkl2Y1QNnCR22Lz1GA4laktzcB0RgLhCrmUZOcsKRrRu16/JIulzB0V8o5p
         XZ+U7MaFuMkyHyQUGmQop/l191OIQQKI/anR8BHWRq/AZqOm/I3NduLsh6+WjK8atnZg
         Fa9ScOWMAQ4mafnJgzupWrMfj3cmW08Le/PPAPQPVMdFGdGQNiODOZ+WZFE7ofpElYKU
         8gPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784058144; x=1784662944;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zxVjA6Wf03JWIhHpDHaN7R3Ti8g+kay7fZlb8zOdmF0=;
        b=F/ChpW2yEwjWHiZ3Wbdx6g7PRZxVvOXctz1FiG96ltjKUR1X7iANDVS/YbirLrSfUU
         31iyllTV+BGHwTbNIGuwTzyg++Xiz7nKPtaS2PGehW8geAfSKzHAffWI2wsGQS4WmOeD
         YcsxPKLwVeVmH20xdmfZCNHddq2/eqcmw3Z8Ok5CI8Apj1+nDEPYPuieQLMmf1Bhbw3Z
         8GAlfBe61Dh9ekgmnoktas38NR2p4PL/NrgdSPRpaRPB3OFk5bQfQRc5WTcCf26e3LBJ
         lMvzmOjMT2OFGrPNhgzL+CygG07DFc0GXxvSwsMh1LauuGCbHx1TIEL1CakEqq00RDI3
         hWRg==
X-Forwarded-Encrypted: i=1; AFNElJ993kPuv6vYTKzcZ2dojoJqJ9Vxv7UYH/itXRVdowcUMB3crL+oR/cDKbp4Wtz7g529P6Hm9ztP6mr8I2fuUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxP/O8F9GM016vNk/vB10NsSntdSfGtjwT3ryYJE3idGiHuJyhx
	G7RJJIiVlcGHe7JknD4k1iiEEKI4kwNxgnUItjuC7+S4QaYOQS5tQd1bfZsTxbaUqBoAxHVvgBG
	Wq72cNOR4VJp9VtYoqO7uowmNqRzB75E=
X-Gm-Gg: AfdE7cmzOp0tWm/nm1JmX4rKiWeM80gSXBVV3KeLgfLsHpc+XPjDSBnPIVeC9ATJxAY
	dTc8RquV5+UUG424CdUSg0AJsxTOkYzGsZdKrSsO6j5mIlSXQlTG/sHJWlgYz11ixw5MydS5HUO
	oCV3SaOk/mUSY/AeRMRec8hHnYXTZ3GFqfKNPxp4H6ALWaIgbmdvPqCTMi0HtxIWVS+MZPmipsV
	OPig2En9eN5cTTvl5xmI7yaptWGId0x66/7URAAWWnp4s64ybjb8soEFmIniGXHiNDsJJBgA6Rz
	IZmjk8sG3LL2eFkgAaZyG7yNF6KHMnU=
X-Received: by 2002:a05:6871:54c:b0:447:7ad3:329b with SMTP id
 586e51a60fabf-4562b2d1908mr102271fac.6.1784058143884; Tue, 14 Jul 2026
 12:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260713230028.8046-1-mohamedaymanworkspace@gmail.com> <20260714104252.NuPnAQyJ@linutronix.de>
In-Reply-To: <20260714104252.NuPnAQyJ@linutronix.de>
From: MOHAMED AYMAN <mohamedaymanworkspace@gmail.com>
Date: Tue, 14 Jul 2026 22:42:12 +0300
X-Gm-Features: AUfX_mw9n5xrRjUjg8K5isFflq9MeU31PnE9r0_YUAnoBatRP-2yXpKQ2cbGW5Q
Message-ID: <CABWZVho1=oJHU6U16Kc-Nh1bQbn07oz7PPkM9Diy=JS0beGjFQ@mail.gmail.com>
Subject: Re: [PATCH v2] coresight: Fix scheduling while atomic in coresight_put_percpu_source_ref()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, 
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <coresight@lists.linaro.org>, 
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Thank you for the review and the feedback.

Regarding the commit message:
You are completely right. I will update the wording in the v4 patch to
explicitly state that it "uses a spinlock_t for locking which becomes
a sleeping lock on PREEMPT_RT" instead of calling it an rt_mutex
directly.

Regarding the module-ref counter:
We don't explicitly bump the module reference count for each new
device. Instead, we rely on `destroy_workqueue(coresight_wq)` inside
`coresight_exit()`. `destroy_workqueue()` synchronously drains all
pending work items before returning, which ensures no deferred puts
are executed after the module is unmapped.

Regarding deferring coresight_device_release() vs put_device():
My initial v1 patch did exactly what you suggested, it only deferred
the body of `coresight_device_release()`. However, it was pointed out
that `put_device()` synchronously recurses into `kobject_cleanup()`,
which invokes the child's release function and immediately afterwards
calls `kobject_put(parent)`.

If we only defer the child's release callback, the `put_device()` call
itself will still execute in the atomic CPU_PM notifier context. If
the parent device's release path acquires any sleeping locks, we will
still hit a "scheduling while atomic" panic. Deferring `put_device()`
entirely protects against this parent cascade.

If it is strictly guaranteed that Coresight parent devices (liike
AMBA) will never sleep during their release paths, I can happily
revert to the simpler approach of just deferring
`coresight_device_release()`.

Would you prefer I revert to deferring just the release function, or
keep the current architecture to safeguard the parent put?

Best regards,,
Mohamed Ayman

On Tue, Jul 14, 2026 at 1:42=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-07-14 02:00:27 [+0300], Mohamed Ayman wrote:
> > Dropping the last reference to a coresight_device triggers a kernel pan=
ic
> > on PREEMPT_RT builds due to a "scheduling while atomic" violation.
> >
> > During CPU idle transitions, coresight_cpu_pm_notify() runs with
> > interrupts disabled. It eventually calls put_device(), which can
> > synchronously trigger the device's release callback and drop the parent
> > device's reference. On PREEMPT_RT, free_percpu() takes a sleeping lock
> > (rt-mutex), and the parent's release callback might also sleep. Sleepin=
g
>
> It is a spinlock_t which we refer as a sleeping lock. There is "struct
> rt_mutex" which is somehow different.
> I would suggest to word it like "uses a spinlock_t for locking which
> becomes a sleeping lock on PREEMPT_RT".
>
> > in this atomic PM context crashes the system.
> >
> > A previous patch tried deferring just the coresight_device_release() bo=
dy,
> > but this still left the synchronous put_device() call dangerously expos=
ed
> > to sleeping parent release functions.
> >
> > Fix this by entirely deferring the put_device() call to process context=
.
> > We add a pending counter (put_pending) and a work_struct to the coresig=
ht
> > device. When releasing a reference, we increment the counter and queue
> > the work. A worker thread then safely drains the counter and calls
> > put_device(). The counter prevents leaking references if multiple puts
> > are queued before the worker even has a chance to run.
> >
> > To prevent a use-after-free race condition during module unload, the wo=
rk
> > is queued on a dedicated coresight_wq which is safely drained and
> > destroyed in coresight_exit().
>
> Do you have anything that keeps the module-ref counter up with each new
> device?
>
> > Finally, remove the unnecessary raw_spinlock_irqsave in the put path,
> > as dropping a reference doesn't require protecting the per-CPU table.
> >
> > Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
> > ---
> =E2=80=A6
> > @@ -163,16 +175,9 @@ void coresight_put_percpu_source_ref(struct coresi=
ght_device *csdev)
> >       if (!csdev || !coresight_is_percpu_source(csdev))
> >               return;
> >
> > -     guard(raw_spinlock_irqsave)(&coresight_dev_lock);
> > +     atomic_inc(&csdev->put_pending);
> >
> > -     /*
> > -      * TODO: coresight_device_release() is invoked to release resourc=
es when
> > -      * the device's refcount reaches zero. It then calls free_percpu(=
),
> > -      * which acquires pcpu_lock =E2=80=94 a sleepable lock when PREEM=
PT_RT is
> > -      * enabled. Since the raw spinlock coresight_dev_lock is held, th=
is can
> > -      * lead to a potential "scheduling while atomic" issue.
> > -      */
> > -     put_device(&csdev->dev);
> > +     queue_work(coresight_wq, &csdev->put_work);
>
> What about you keep this as-is and just delay coresight_device_release()
> instead?
>
> >  }
> >
> >  struct coresight_device *coresight_get_source(struct coresight_path *p=
ath)
>
> Sebastian
