Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FF40960B
	for <linux-rt-devel@lists.linux.dev>; Tue, 26 May 2026 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779820339; cv=none; b=CsVO9eqCedNNtCNfbU0Dk9tH+x3Jvu68um1xPQIIzshCNXd1EobdSi0yhU4CUZPIKXxoSWHFUTH7dwHwT/BDBWuFrAhRUUubEpxPm905bkvXGlQy9TnD9szpmeUjGcMvQSiOCuoNOsgJfLXx3V5+xN0H5k2CDTDDxZ4/X5GPCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779820339; c=relaxed/simple;
	bh=pZo2H5+ocqQaorZI3b4JWMzXA5Bp86AfP5N0FqwXx6c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Hc/veU7SrIHGWS0+IIhJkTLWkxn/ZSbGONb7iIcFn2QRPLSivVCakOEvpOwraXRmmKytLjCtxVvfS955JsP7SSubRi3TN3X/yS4eES/QK9alvPmicykHTZUdBbtLHziycOL6A778Eth/GjqCi6zomJyHqqUGvrBp6zbiEpGoi0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de; spf=pass smtp.mailfrom=by-online.de; dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b=P50Dx3Hl; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=by-online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b="P50Dx3Hl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=by-online.de;
	s=s1-ionos; t=1779820312; x=1780425112; i=by@by-online.de;
	bh=i/jbEPQLIWjZHBbHDApvAtUV9WTwOCUlrR9APLNT0Yo=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=P50Dx3Hl5cBl7yIR91i/TX9nqiwKQJ+qUmaBvj6DCz/jsKrDCtUV9zIlDAVvpR1b
	 QQE5eQHsIlpjC9qPyR3K8j2NarLbzoxGg1t10QP/XunLBlztdCwlz8qDNaEtTyZMR
	 2cmXKYGedEiouH65p76et0vXPwbN5oYq8YNnrIBnb/oBRtqRXSuXdA41xm+1GfK/s
	 jSjlQA8vG7h/HZNNhcQdE+SfoO1PfuVTki+n9oJOwtQ7WHdvhOUf3D7pw2ZvmATdE
	 pU2EM94CtrMDSDUNvLE+dS3MbAczVhOgs9GJQzS/cRcg9hgDwY89bjoU0EgBAc5ji
	 higzy1qX2lc8D+cHuQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N5VLY-1xPfpS1Q2U-011xDz; Tue, 26
 May 2026 20:31:52 +0200
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v6 3/3] pps: convert pps_device.lock to raw_spinlock_t
From: Michael Byczkowski <by@by-online.de>
In-Reply-To: <ahXdZFrw79US8MO3@mozart.vkv.me>
Date: Tue, 26 May 2026 20:31:39 +0200
Cc: linux-kernel@vger.kernel.org,
 Rodolfo Giometti <giometti@enneenne.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eliav Farber <farbere@amazon.com>,
 linux-rt-devel@lists.linux.dev,
 David Laight <david.laight.linux@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D37E5301-F98E-4688-8422-E20FF81C7018@by-online.de>
References: <cover.1779733602.git.calvin@wbinvd.org>
 <3fa6ae908b37681ec6857b413179b67a7655c753.1779733602.git.calvin@wbinvd.org>
 <ahXdZFrw79US8MO3@mozart.vkv.me>
To: Calvin Owens <calvin@wbinvd.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-Provags-ID: V03:K1:5JeKgEG4IQYnT9hPnIXtuivXmVQy4ZrOowj6dzRIqqj1PaPA/A3
 E6UTwOB6m/QbFxI5CNEvn4ct5XKVboYHXHDm1wQkRDWjIM6JtnITyGXFLNZMh03uhV5GtBo
 yOH8aiNcAiJ/Ez7QhxNQbDR37NwhXeMDYt1pWvVz6CrOhxk1D9p6fdhuEKrd6uSgoWwAI0u
 C56ZPb0HO5ZxPHqs2T2tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W+emTLgPkAg=;b23uaeU6kHfuP3/G1KJj/j4sIvE
 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
 dl7aabLvpq7dbfdQaMAnk71QqaBX4=

Dear Calvin,

Thank you very much for catching this and for going the extra mile
of actually running v6 with CONFIG_DEBUG_ATOMIC_SLEEP -- I hadn't,
and clearly I should have. You're right that this is the same
pattern as the v2->v3 fix Nikolaus Buchwitz reported for the
pps_kc path back then; I just failed to apply the same reasoning
to pps_event() in kapi.c.

v7 is on GitHub with your fix folded in:

  https://github.com/by/linux-PPS/tree/pps-rt-v7
  Tip SHA: 58043ec91e1720ca18bb0dd5d83d3f6cdcd3f3da
  Base:    0d9363a764d9d601a05591f9695cea8b429e9be3

Patch 3/3's trailer block credits you with Reported-by, Closes
(pointing at your lore archive entry), Suggested-by, and Tested-by.
Rodolfo's Acked-by on 3/3 is dropped since the change is
substantive; the cover letter notes this and invites him to re-ack.

Would you be willing to relay v7 the same way? Recipient list per
scripts/get_maintainer.pl (same as v6):

  To:  Rodolfo Giometti <giometti@enneenne.com>
       Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Cc:  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
       Clark Williams <clrkwllms@kernel.org>
       Steven Rostedt <rostedt@goodmis.org>
       Thomas Gleixner <tglx@linutronix.de>
       linux-kernel@vger.kernel.org
       linux-rt-devel@lists.linux.dev

Cover letter blurb for the 0000 file:

----------------------------------------------------------------
[paste the blurb from your v7 cover letter -- the text starting
"This is v7 of the PPS PREEMPT_RT patchset..." through the end
of the "All three patches are tested..." paragraph]
----------------------------------------------------------------

Thank you very much again, this would have bitten people in the field
had v6 landed as-is.

Best regards,
	Michael


> On 26. May 2026, at 19:50, Calvin Owens <calvin@wbinvd.org> wrote:
>=20
> On Monday 05/25 at 12:49 -0700, Calvin Owens wrote:
>> From: Michael Byczkowski <by@by-online.de>
>>=20
>> pps_device.lock is acquired from the PPS hardirq path
>> (pps_event() and friends). On PREEMPT_RT, spinlock_t becomes a
>> sleeping rt_mutex, so taking it in hardirq context produces
>> "BUG: scheduling while atomic" splats and breaks PPS event
>> delivery entirely.
>>=20
>> Convert pps_device.lock to raw_spinlock_t, which remains a true
>> spinning lock on RT, and update all call sites in kapi.c and
>> pps.c to use raw_spin_lock_irqsave() / raw_spin_unlock_irqrestore()
>> (and the _irq variants where appropriate). The critical sections
>> are short and deterministic, so raw_spinlock_t semantics are
>> appropriate.
>>=20
>> No functional change on non-RT kernels.
>>=20
>> Tested-by: Michael Byczkowski <by@by-online.de>
>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>> Signed-off-by: Michael Byczkowski <by@by-online.de>
>> Tested-by: Calvin Owens <calvin@wbinvd.org>
>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>> ---
>> drivers/pps/kapi.c         |  6 +++---
>> drivers/pps/pps.c          | 16 ++++++++--------
>> include/linux/pps_kernel.h |  2 +-
>> 3 files changed, 12 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
>> index 1bf0335a1b41..dc7fac75ec27 100644
>> --- a/drivers/pps/kapi.c
>> +++ b/drivers/pps/kapi.c
>> @@ -102,7 +102,7 @@ struct pps_device *pps_register_source(struct =
pps_source_info *info,
>> pps->info.echo =3D pps_echo_client_default;
>>=20
>> init_waitqueue_head(&pps->queue);
>> - spin_lock_init(&pps->lock);
>> + raw_spin_lock_init(&pps->lock);
>>=20
>> /* Create the char device */
>> err =3D pps_register_cdev(pps);
>> @@ -167,7 +167,7 @@ void pps_event(struct pps_device *pps, struct =
pps_event_time *ts, int event,
>>=20
>> timespec_to_pps_ktime(&ts_real, ts->ts_real);
>>=20
>> - spin_lock_irqsave(&pps->lock, flags);
>> + raw_spin_lock_irqsave(&pps->lock, flags);
>>=20
>> /* Must call the echo function? */
>> if ((pps->params.mode & (PPS_ECHOASSERT | PPS_ECHOCLEAR)))
>> @@ -214,6 +214,6 @@ void pps_event(struct pps_device *pps, struct =
pps_event_time *ts, int event,
>> kill_fasync(&pps->async_queue, SIGIO, POLL_IN);
>> }
>>=20
>> - spin_unlock_irqrestore(&pps->lock, flags);
>> + raw_spin_unlock_irqrestore(&pps->lock, flags);
>> }
>> EXPORT_SYMBOL(pps_event);
>=20
> The Sashiko LLM says:
>=20
>    Both wake_up_interruptible_all() and kill_fasync() internally take
>    standard spinlocks and rwlocks, which map to sleepable rt_mutexes =
on
>    PREEMPT_RT.
>=20
> It does seem to be correct, with CONFIG_DEBUG_ATOMIC_SLEEP I get:
>=20
>    BUG: sleeping function called from invalid context at =
kernel/locking/spinlock_rt.c:48
>    in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 31, name: =
ktimers/1
>    preempt_count: 1, expected: 0
>    RCU nest depth: 2, expected: 2
>    CPU: 1 UID: 0 PID: 31 Comm: ktimers/1 Not tainted =
7.1.0-rc5-00004-g85f7c8ee247a-dirty #3 PREEMPT_{RT,LAZY}
>    Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
>    Call trace:
>     show_stack+0x1c/0x38 (C)
>     dump_stack_lvl+0x58/0x78
>     dump_stack+0x14/0x1c
>     __might_resched+0x128/0x168
>     rt_spin_lock+0x34/0x180
>     __wake_up+0x2c/0x70
>     pps_event+0xdc/0x2b0
>     pps_ktimer_event+0x44/0x80
>     call_timer_fn+0x34/0x2d0
>     expire_timers+0xcc/0x228
>     __run_timer_base.part.0+0x18c/0x1a0
>     timer_expire_remote+0x40/0x58
>     tmigr_handle_remote_cpu+0xb4/0x278
>     tmigr_handle_remote_up+0xdc/0x270
>     __walk_groups_from+0x3c/0x98
>     tmigr_handle_remote+0x8c/0xc0
>     run_timer_softirq+0xa4/0xb8
>     handle_softirqs.isra.0+0x100/0x3f8
>     run_ktimerd+0x58/0xa8
>     smpboot_thread_fn+0x204/0x338
>     kthread+0x128/0x150
>     ret_from_fork+0x10/0x20
>=20
> The lock isn't part of the lifetime of the pps_device object, so I =
think
> fixing that really is as simple as not holding the raw lock across the
> wakeup, something like below?
>=20
> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
> index dc7fac75ec27..f85929d01e3d 100644
> --- a/drivers/pps/kapi.c
> +++ b/drivers/pps/kapi.c
> @@ -203,17 +203,16 @@ void pps_event(struct pps_device *pps, struct =
pps_event_time *ts, int event,
>=20
> captured =3D ~0;
> }
>=20
> pps_kc_event(pps, ts, event);
> + if (captured)
> + pps->last_ev++;
> + raw_spin_unlock_irqrestore(&pps->lock, flags);
>=20
> /* Wake up if captured something */
> if (captured) {
> - pps->last_ev++;
> wake_up_interruptible_all(&pps->queue);
> -
> kill_fasync(&pps->async_queue, SIGIO, POLL_IN);
> }
> -
> - raw_spin_unlock_irqrestore(&pps->lock, flags);
> }
> EXPORT_SYMBOL(pps_event);
>=20
> Thanks,
> Calvin
>=20
>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>> index de1122bb69ea..75eb7973e37c 100644
>> --- a/drivers/pps/pps.c
>> +++ b/drivers/pps/pps.c
>> @@ -106,12 +106,12 @@ static long pps_cdev_ioctl(struct file *file,
>> case PPS_GETPARAMS:
>> dev_dbg(&pps->dev, "PPS_GETPARAMS\n");
>>=20
>> - spin_lock_irq(&pps->lock);
>> + raw_spin_lock_irq(&pps->lock);
>>=20
>> /* Get the current parameters */
>> params =3D pps->params;
>>=20
>> - spin_unlock_irq(&pps->lock);
>> + raw_spin_unlock_irq(&pps->lock);
>>=20
>> err =3D copy_to_user(uarg, &params, sizeof(struct pps_kparams));
>> if (err)
>> @@ -142,7 +142,7 @@ static long pps_cdev_ioctl(struct file *file,
>> return -EINVAL;
>> }
>>=20
>> - spin_lock_irq(&pps->lock);
>> + raw_spin_lock_irq(&pps->lock);
>>=20
>> /* Save the new parameters */
>> pps->params =3D params;
>> @@ -166,7 +166,7 @@ static long pps_cdev_ioctl(struct file *file,
>> pps->params.assert_off_tu.flags =3D 0;
>> pps->params.clear_off_tu.flags =3D 0;
>>=20
>> - spin_unlock_irq(&pps->lock);
>> + raw_spin_unlock_irq(&pps->lock);
>>=20
>> break;
>>=20
>> @@ -193,7 +193,7 @@ static long pps_cdev_ioctl(struct file *file,
>> return err;
>>=20
>> /* Return the fetched timestamp and save last fetched event  */
>> - spin_lock_irq(&pps->lock);
>> + raw_spin_lock_irq(&pps->lock);
>>=20
>> pps->last_fetched_ev =3D pps->last_ev;
>>=20
>> @@ -203,7 +203,7 @@ static long pps_cdev_ioctl(struct file *file,
>> fdata.info.clear_tu =3D pps->clear_tu;
>> fdata.info.current_mode =3D pps->current_mode;
>>=20
>> - spin_unlock_irq(&pps->lock);
>> + raw_spin_unlock_irq(&pps->lock);
>>=20
>> err =3D copy_to_user(uarg, &fdata, sizeof(struct pps_fdata));
>> if (err)
>> @@ -281,7 +281,7 @@ static long pps_cdev_compat_ioctl(struct file =
*file,
>> return err;
>>=20
>> /* Return the fetched timestamp and save last fetched event  */
>> - spin_lock_irq(&pps->lock);
>> + raw_spin_lock_irq(&pps->lock);
>>=20
>> pps->last_fetched_ev =3D pps->last_ev;
>>=20
>> @@ -294,7 +294,7 @@ static long pps_cdev_compat_ioctl(struct file =
*file,
>> memcpy(&compat.info.clear_tu, &pps->clear_tu,
>> sizeof(struct pps_ktime_compat));
>>=20
>> - spin_unlock_irq(&pps->lock);
>> + raw_spin_unlock_irq(&pps->lock);
>>=20
>> return copy_to_user(uarg, &compat,
>> sizeof(struct pps_fdata_compat)) ? -EFAULT : 0;
>> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
>> index aab0aebb529e..f2fe504071ed 100644
>> --- a/include/linux/pps_kernel.h
>> +++ b/include/linux/pps_kernel.h
>> @@ -59,7 +59,7 @@ struct pps_device {
>> void const *lookup_cookie; /* For pps_lookup_dev() only */
>> struct device dev;
>> struct fasync_struct *async_queue; /* fasync method */
>> - spinlock_t lock;
>> + raw_spinlock_t lock;
>> };
>>=20
>> /*
>> --=20
>> 2.47.3


