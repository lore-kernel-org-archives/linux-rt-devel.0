Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D92D7DC4
	for <linux-rt-devel@lists.linux.dev>; Thu, 16 Jul 2026 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171269; cv=pass; b=o2ecISGIf7T8AcvtyEO9/CkppzXNYdDnB1X0lCQw1ewu4a18vC+GBoqiD/ylFbvLCYmQTDUzSzzUI/NbvrBS4xqYsZzHUZUNduI+FH1wc9jbdo/gxCvEELj67KZ29AJ9LZ3AkGjHNrtfEgb1Dw6sXLOl54XOuqTDACFt8R1PINk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171269; c=relaxed/simple;
	bh=CmxVaXpW6qJtS71NqsPOqwTeMC1zLKq8D86bHREOqT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eN936JL/ksxuoe8GndtDojr7sePfLzqK9FKJJOQcqW/ANjEEQAXbt8R96yQK5lJK7D5Yk4wZpBm7yXNsPkXLIEzS/orKWE8QUCZKPH9fF/7/mbLmZnJs/rH6B/CXXHp/Puhdzk+m78GObw4NMckLVne84TozbGSSrKH5v35O1/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMCyZ8IB; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMCyZ8IB"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a378a2cfdfso1705069eaf.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 20:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784171267; cv=none;
        d=google.com; s=arc-20260327;
        b=CXezwlnqK3QOlB2zjT+asTySv3Xi9j7CDSYijaTCZ8jdKwsLd/+3gC+UMQiPhG/CXJ
         XALEZMWv+sOjkhGb0t+KM8nkkuObiJ4FihWDOh2HysxiBTUndurmzIskEAajE9SehQIN
         Wt9EAMTJuQ+KsigXCFyBJit7g3thXhbSaBTyujMdVrwfMiDlfqGgluTQeXNVcI7Z+Twr
         qIIWzhylyHp3dXGFboO5swsrsEcFbN+G8a7cpVaqDIKEVYhA7Mu1G0WsI2m/hR7T/Ru7
         BBlCzsu0M6sO9FOxT029U/vhVqTV+a4EBjbR5atR3hnNFf4Fd0uVK+h4Ue3iIGcg5Qrf
         XkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q1RuOVbbGHwBjAA7Tjq8tp/2Sf1Tzdn7z+0lxdME/f8=;
        fh=XP6/4zLpdOHTG70q0FdQzxOwnhy9XGCQJXqOecmkr1U=;
        b=cvlSiKHdQr6690rSFXtDA0kgGNCxYsqTmPDFkL9quGqILkyzC9azIoc7i4fNLlVUA0
         QskqLZg2T0ctO7lhtCoA7alJ+SGlGrd47MtocVJJ9PGXoKgbCpPq11Sbt6nN4IGn3WBS
         76RfKEAsBqP+hE4fEXbH05AH/Te6ed5i3FEPCex23RFotqkPzV7kVJEtbOrnqAFiJGVR
         ionZfNugcADqgJo7/szUvCIlHTB/iGDeUNtQ2FDCAUlDK04UI+H/+Kp9f3hJU5wloKQQ
         EK5NbnUwzFyDErfamg5snWOowsZ2GKa3Cc5/qAXsDuFLa5jVlrybWKndZpaAUT/CvQiF
         +npg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784171267; x=1784776067; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q1RuOVbbGHwBjAA7Tjq8tp/2Sf1Tzdn7z+0lxdME/f8=;
        b=hMCyZ8IB+uytE7ffZtinG+5017z0zgVDsgG8B1Gj6ZFfTvPDVX+oWES7BYU+Sp3mzl
         y/c8Vznq0Tccgl/JMCIyHRuilmpB/t1gz0mDz2RLQfgjjq7NBwTxpw19MZahWq0PwgCw
         ppXO8zh5Qrxy6gvO0LyfjfFs5NzQpk2EdfXRpHPoMQWOyBPVNqx2k69mvLBJ5RUsq8Up
         0g3NgNL5UoH/LpVWTT4Qqida13iXPwMV4aJLB0i9w+A6H1p3tuDIpyZfeKpOLXOdnrGO
         JooXF1HFHMP2zc6hkBmQPKlClpsABcux5pd+PfmMe9b2e+wOfW//cJyc9lcAPl5T/Ajz
         gz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784171267; x=1784776067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q1RuOVbbGHwBjAA7Tjq8tp/2Sf1Tzdn7z+0lxdME/f8=;
        b=GjGJy5zcNaHaIpjC/qK0NzMaGmsB8i072QEgNddu18ni3qGW2vjaDXjmHzPBe5NLYz
         SPKPouT4SFDRArCaRKpp58MGpjAcE3FwF4jL9jTrK+sDYvjJaeRW2Sm0/Omlyufdrsc6
         r788mTQjC1Wh8MrEBi65r1USupRQ94B5i2PJnVYWdkom123a//TJrlR1zaipGgXMYTGP
         HZekNytKYTGTOtxmQ+QOPyKCwqks2lgGyOEIMQE6iw6n+OH/zaFeh5xTEqRnAhNbLwo/
         rdIcG37sTg58w4nhvZyE8BpxG/9YNlqojtkcQf1Swt/LOda8xivaUq/U3ePIgQbcbgpF
         8FDA==
X-Forwarded-Encrypted: i=1; AHgh+RrmKIRCKFqMmBPj60BKuL27ZIqXebDUuej3M9SGcz73VqiOZOhtFiGxqvzA+SQZpd3LLpORC4EPnTNPlEI08A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0N81Sr6zwUQPZGqHgEg95NOg73tigVzY71LxHS9v9n1hfQy5t
	xmh143Frwse4L5UNQdgsuytN5SzB98XlxQMzUF8Cs+MX4/PC6nuBroadwk1Lkh0l9f0GJZmdlb9
	slvLOYeD/880IBqGT6f9vohQWy/TzWRU=
X-Gm-Gg: AfdE7cnfbAnv3vmUA/chaJvZX+VhX4GLLlrIc/JjGcsujLi6KWUDXS1/eqFVt4kR7O7
	kTwCV46R9+HK9MY7nGHynwHQJbvZN73an+sbd36YrLcfiqu9JxKFJKEVRJK9gRECS3CHMo+2hro
	didVS6XUj1cE8t3GBJR/qzMHVv7jtqLTQoM2ssgiV0qo4FXsPcS6o2e8hVYFYeegNl05k/xNGQv
	78B9tDEaHqeWFHmc/OYjsFNH9FeToYmisckF2jf9/hCb7Bu3Rf+Mv1yWjm08p+xxLqig2YS86fh
	v/gEnbYHm08opmKoFmzj
X-Received: by 2002:a05:6820:4dc4:b0:6a1:50eb:2118 with SMTP id
 006d021491bc7-6a39a71fd1amr11747988eaf.60.1784171266680; Wed, 15 Jul 2026
 20:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260713230028.8046-1-mohamedaymanworkspace@gmail.com> <20260714104252.NuPnAQyJ@linutronix.de>
 <CABWZVho1=oJHU6U16Kc-Nh1bQbn07oz7PPkM9Diy=JS0beGjFQ@mail.gmail.com> <20260715065832.qI7c2Px5@linutronix.de>
In-Reply-To: <20260715065832.qI7c2Px5@linutronix.de>
From: MOHAMED AYMAN <mohamedaymanworkspace@gmail.com>
Date: Thu, 16 Jul 2026 06:07:35 +0300
X-Gm-Features: AUfX_mzInr4Bf6hg3MJSbiLXrCzek5Wv-Tac3ugtCjr0XQO0DlFi8b-yt8eOcyY
Message-ID: <CABWZVhq5yN6uP-YJC07EVt6+AqmGoUcXx8RTdrYssQ9coQ1Q5Q@mail.gmail.com>
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

First Thing WOOOOOOOW, This is a brilliant observation and entirely
changes the approach.

To answer your question regarding how the reference drops to 0 in the
PM notifier:
You are exactly right that the device should have a base reference.
The only way `put_device()` inside the CPU_PM notifier drops the lastt
reference (reaching 0) is if there is a race condition. If another CPU
concurrently calls `coresight_unregister()`, it drops the base
reference. That leaves our CPU's PM notifier holding the absolute last
reference. When our PM notifier calls `put_device()`, it inadvertently
triggers the release cascade from an atomic context.

As you correctly pointed out, `coresight_cpu_get_active_path()` is the
root cause. It lazily reuses `coresight_get_percpu_source_ref()`,
which takes a kobject reference (`get_device()`) intended for path
building.

Since `coresight_cpu_pm_notify()` runs with local IRQs disabled, we do
not need to manipulate the kobject refcount at all. We can simply read
the per-cpu pointer under `coresight_dev_lock`, check the mode, and
return the path.

If we avoid the `get_device()` / `put_device()` entirely in the PM
path, we completely eliminate the bug at its source. We can throw away
all the complex workqueue and pending counter logic from v1/v2.

The fix would simply be rewriting `coresight_cpu_get_active_path()` like th=
is:

static struct coresight_path *coresight_cpu_get_active_path(enum cs_mode mo=
de)
{
struct coresight_device *source;
struct coresight_path *path =3D NULL;

guard(raw_spinlock_irqsave)(&coresight_dev_lock);

source =3D per_cpu(csdev_source, smp_processor_id());
if (source && (coresight_get_mode(source) & mode))
path =3D source->path;

return path;
}

This means we don't need `coresight_put_percpu_source_ref()` inside
the PM path at all.

Does this align with your suggestion !??
If so, I will prepare a v3 patch that drops the workqueue architecture
entirely and just applies this much simpler fix..

Best regards,
Mohamed Ayman

On Wed, Jul 15, 2026 at 9:58=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-07-14 22:42:12 [+0300], MOHAMED AYMAN wrote:
> > Hi Sebastian,
> Hi Mohamed,
>
> > Thank you for the review and the feedback.
> >
> > Regarding the commit message:
> > You are completely right. I will update the wording in the v4 patch to
> > explicitly state that it "uses a spinlock_t for locking which becomes
> > a sleeping lock on PREEMPT_RT" instead of calling it an rt_mutex
> > directly.
> >
> > Regarding the module-ref counter:
> > We don't explicitly bump the module reference count for each new
> > device. Instead, we rely on `destroy_workqueue(coresight_wq)` inside
> > `coresight_exit()`. `destroy_workqueue()` synchronously drains all
> > pending work items before returning, which ensures no deferred puts
> > are executed after the module is unmapped.
>
> But what stops the module unload before all devices are released?
>
> > Regarding deferring coresight_device_release() vs put_device():
> > My initial v1 patch did exactly what you suggested, it only deferred
> > the body of `coresight_device_release()`. However, it was pointed out
> > that `put_device()` synchronously recurses into `kobject_cleanup()`,
> > which invokes the child's release function and immediately afterwards
> > calls `kobject_put(parent)`.
> >
> > If we only defer the child's release callback, the `put_device()` call
> > itself will still execute in the atomic CPU_PM notifier context. If
> > the parent device's release path acquires any sleeping locks, we will
> > still hit a "scheduling while atomic" panic. Deferring `put_device()`
> > entirely protects against this parent cascade.
> >
> > If it is strictly guaranteed that Coresight parent devices (liike
> > AMBA) will never sleep during their release paths, I can happily
> > revert to the simpler approach of just deferring
> > `coresight_device_release()`.
> >
> > Would you prefer I revert to deferring just the release function, or
> > keep the current architecture to safeguard the parent put?
>
> Well deferring as I suggested if the kobj goes away is a not good.
> That I part I didn't get: You have the call chain:
> |  coresight_cpu_pm_notify() (IRQs off)
> |    -> coresight_put_percpu_source_ref()
> |      -> put_device()
> |        -> coresight_device_release()
> |          -> free_percpu()
>
>
> What you skipped is coresight_cpu_get_active_path() and this one has a
> get and a put. Your put has a irqlock on coresight_dev_lock which I am
> not sure you need. But more importantly, why is the reference going back
> to 0? There would have to be a coresight_clear_percpu_source() in
> between, right?
>
> If you could avoid grabbing a reference in the coresight_cpu_pm_notify()
> path then we wouldn't have that problem or is there more to it?
>
> > Best regards,,
> > Mohamed Ayman
>
> Sebastian
