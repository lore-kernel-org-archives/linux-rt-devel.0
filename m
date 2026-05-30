Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1878253B42
	for <linux-rt-devel@lists.linux.dev>; Sat, 30 May 2026 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139669; cv=none; b=klNxVtl045YyyP+eSa1UswxDz4uexYqwctgtf0DPusswJ+V36p7LWeUIW1o4smu6nnopCor3wv4I0Q0UyvcaucHl2OL7KCRQs4Yb1zFGN+on6zCmViE87ninSTpqAnsXBTzZRXEe5PT12O8qkdNofSialu6epLOvP4G6pJrS92o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139669; c=relaxed/simple;
	bh=PbMZ7A4t0/6aG2SM2Y/UFNzeaDLrCdd2XTLZ9YZrc/w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iZ0ef9ubmIaUMBpF/JVV0vu1rEvny3l2EfANvYQ7OGt1ktxYrJUrwWnnj9pEtDBnBXsOyr+NWV1+sBSGy3OIoK85FaJ4KV9URxPZyYL00+PmyCxjI3DO1sE/HFVSHFfxC3T8+NO2+RW5QJeqYnZo0HG2/gT5I40PZxQE6Kfr7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de; spf=pass smtp.mailfrom=by-online.de; dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b=JEoX1xlY; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=by-online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b="JEoX1xlY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=by-online.de;
	s=s1-ionos; t=1780139655; x=1780744455; i=by@by-online.de;
	bh=CMC07LBtxUgDh6+yxPvQ+bpakc4b0bDq23/IQTK/Y2E=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=JEoX1xlYtSUleuJuAt5J/lISlcg73RmghnFv2XHQEqd8XtfoVKtvetJRgokgqVxy
	 pPpzn2oVLJ71qSAjol/KRQXDjcSo9+XWtnEvdSMCN/4daUAUmYHeYMCcP00ymXmgi
	 OIVk8i/94CyB2gqNGJdgYBX+6OyBTz5ujyZVs8AFxBS819pd+QyFwbgB8D5T5LY9l
	 FY/0MrIA5Qmyv5V8/yFr9WPHc5vfgUOTeOB3M36ztV1cV6Zh+WylaPaa5MreL7jp5
	 1N/ZUpqRCUT6SRWy1aoSmigVxWKI85et9aswn4c2z0TC8qv35EAg2OThQvLr0k4/n
	 k21h47FVscb1A3MJjA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mcp7M-1x1n771pBK-00gUkM; Sat, 30
 May 2026 13:14:15 +0200
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
In-Reply-To: <D37E5301-F98E-4688-8422-E20FF81C7018@by-online.de>
Date: Sat, 30 May 2026 13:14:03 +0200
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
Message-Id: <62B8BCBF-72E4-4E73-81A4-1C6C20DD788B@by-online.de>
References: <cover.1779733602.git.calvin@wbinvd.org>
 <3fa6ae908b37681ec6857b413179b67a7655c753.1779733602.git.calvin@wbinvd.org>
 <ahXdZFrw79US8MO3@mozart.vkv.me>
 <D37E5301-F98E-4688-8422-E20FF81C7018@by-online.de>
To: Calvin Owens <calvin@wbinvd.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-Provags-ID: V03:K1:nXSJpdU0KRZDBUybKsGTvvrW8lqg8z3pINl6xDRlLeBffxKo3hE
 nDQHopM8YpkUKIrG66JzuV4d3QWo7i3nA54FqRFcfy1PIm+jtO2ZTFR6Pfa/ZTibXCQ0T0S
 V6l6l/beoQxJ9QVBTVmo4eMsJMcYLJ81OA9I51Np0zeDZtnWeVW7l5UmBa5SM+RcVhWSM7H
 3ExZO6uGtUVEC/tXoH/kw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a5dv6i5bZ04=;pAHdk3HK+jiy6bhHcALtX1qe1TR
 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
 HZ0yobuvKhgXMDBWnL6rh2uFF7VmA=

Dear Calvin,

Thanks again for the testing and the analysis. As discussed, v7 is
just the pps-gpio handler split (old patch 1); patches 2 and 3 are
dropped since neither lock is ever taken in hardirq context.

Branch:
  https://github.com/by/linux-PPS/tree/pps-rt-v7-clean
  Tip SHA: b1a8501137e93bb56dd47878571dca151723bdc3
  Base:    0d9363a764d9d601a05591f9695cea8b429e9be3

Single patch, so no cover letter -- the version history is below the
--- line. Would you be willing to relay it once more?

Recipients (per get_maintainer.pl):
  To:  Rodolfo Giometti <giometti@enneenne.com>
       Greg Kroah-Hartman <gregkh@linuxfoundation.org>
  Cc:  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
       Clark Williams <clrkwllms@kernel.org>
       Steven Rostedt <rostedt@goodmis.org>
       Thomas Gleixner <tglx@kernel.org>
       linux-kernel@vger.kernel.org
       linux-rt-devel@lists.linux.dev

To regenerate from the branch:

    git fetch https://github.com/by/linux-PPS.git pps-rt-v7-clean
    git format-patch -1 \
        --subject-prefix=3D"PATCH v7" \
        --base=3D0d9363a764d9d601a05591f9695cea8b429e9be3 \
        FETCH_HEAD

Thanks and best regards,
	Michael



> On 26. May 2026, at 20:31, Michael Byczkowski <by@by-online.de> wrote:
>=20
> Dear Calvin,
>=20
> Thank you very much for catching this and for going the extra mile
> of actually running v6 with CONFIG_DEBUG_ATOMIC_SLEEP -- I hadn't,
> and clearly I should have. You're right that this is the same
> pattern as the v2->v3 fix Nikolaus Buchwitz reported for the
> pps_kc path back then; I just failed to apply the same reasoning
> to pps_event() in kapi.c.
>=20
> v7 is on GitHub with your fix folded in:
>=20
>  https://github.com/by/linux-PPS/tree/pps-rt-v7
>  Tip SHA: 58043ec91e1720ca18bb0dd5d83d3f6cdcd3f3da
>  Base:    0d9363a764d9d601a05591f9695cea8b429e9be3
>=20
> Patch 3/3's trailer block credits you with Reported-by, Closes
> (pointing at your lore archive entry), Suggested-by, and Tested-by.
> Rodolfo's Acked-by on 3/3 is dropped since the change is
> substantive; the cover letter notes this and invites him to re-ack.
>=20
> Would you be willing to relay v7 the same way? Recipient list per
> scripts/get_maintainer.pl (same as v6):
>=20
>  To:  Rodolfo Giometti <giometti@enneenne.com>
>       Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  Cc:  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>       Clark Williams <clrkwllms@kernel.org>
>       Steven Rostedt <rostedt@goodmis.org>
>       Thomas Gleixner <tglx@linutronix.de>
>       linux-kernel@vger.kernel.org
>       linux-rt-devel@lists.linux.dev
>=20
> Cover letter blurb for the 0000 file:
>=20
> ----------------------------------------------------------------
> [paste the blurb from your v7 cover letter -- the text starting
> "This is v7 of the PPS PREEMPT_RT patchset..." through the end
> of the "All three patches are tested..." paragraph]
> ----------------------------------------------------------------
>=20
> Thank you very much again, this would have bitten people in the field
> had v6 landed as-is.
>=20
> Best regards,
> Michael
>=20
>=20
>> On 26. May 2026, at 19:50, Calvin Owens <calvin@wbinvd.org> wrote:
>>=20
>> On Monday 05/25 at 12:49 -0700, Calvin Owens wrote:
>>> From: Michael Byczkowski <by@by-online.de>
>>>=20
>>> pps_device.lock is acquired from the PPS hardirq path
>>> (pps_event() and friends). On PREEMPT_RT, spinlock_t becomes a
>>> sleeping rt_mutex, so taking it in hardirq context produces
>>> "BUG: scheduling while atomic" splats and breaks PPS event
>>> delivery entirely.
>>>=20
>>> Convert pps_device.lock to raw_spinlock_t, which remains a true
>>> spinning lock on RT, and update all call sites in kapi.c and
>>> pps.c to use raw_spin_lock_irqsave() / raw_spin_unlock_irqrestore()
>>> (and the _irq variants where appropriate). The critical sections
>>> are short and deterministic, so raw_spinlock_t semantics are
>>> appropriate.
>>>=20
>>> No functional change on non-RT kernels.
>>>=20
>>> Tested-by: Michael Byczkowski <by@by-online.de>
>>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>>> Signed-off-by: Michael Byczkowski <by@by-online.de>
>>> Tested-by: Calvin Owens <calvin@wbinvd.org>
>>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>>> ---
>>> drivers/pps/kapi.c         |  6 +++---
>>> drivers/pps/pps.c          | 16 ++++++++--------
>>> include/linux/pps_kernel.h |  2 +-
>>> 3 files changed, 12 insertions(+), 12 deletions(-)
>>>=20
>>> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
>>> index 1bf0335a1b41..dc7fac75ec27 100644
>>> --- a/drivers/pps/kapi.c
>>> +++ b/drivers/pps/kapi.c
>>> @@ -102,7 +102,7 @@ struct pps_device *pps_register_source(struct =
pps_source_info *info,
>>> pps->info.echo =3D pps_echo_client_default;
>>>=20
>>> init_waitqueue_head(&pps->queue);
>>> - spin_lock_init(&pps->lock);
>>> + raw_spin_lock_init(&pps->lock);
>>>=20
>>> /* Create the char device */
>>> err =3D pps_register_cdev(pps);
>>> @@ -167,7 +167,7 @@ void pps_event(struct pps_device *pps, struct =
pps_event_time *ts, int event,
>>>=20
>>> timespec_to_pps_ktime(&ts_real, ts->ts_real);
>>>=20
>>> - spin_lock_irqsave(&pps->lock, flags);
>>> + raw_spin_lock_irqsave(&pps->lock, flags);
>>>=20
>>> /* Must call the echo function? */
>>> if ((pps->params.mode & (PPS_ECHOASSERT | PPS_ECHOCLEAR)))
>>> @@ -214,6 +214,6 @@ void pps_event(struct pps_device *pps, struct =
pps_event_time *ts, int event,
>>> kill_fasync(&pps->async_queue, SIGIO, POLL_IN);
>>> }
>>>=20
>>> - spin_unlock_irqrestore(&pps->lock, flags);
>>> + raw_spin_unlock_irqrestore(&pps->lock, flags);
>>> }
>>> EXPORT_SYMBOL(pps_event);
>>=20
>> The Sashiko LLM says:
>>=20
>>   Both wake_up_interruptible_all() and kill_fasync() internally take
>>   standard spinlocks and rwlocks, which map to sleepable rt_mutexes =
on
>>   PREEMPT_RT.
>>=20
>> It does seem to be correct, with CONFIG_DEBUG_ATOMIC_SLEEP I get:
>>=20
>>   BUG: sleeping function called from invalid context at =
kernel/locking/spinlock_rt.c:48
>>   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 31, name: =
ktimers/1
>>   preempt_count: 1, expected: 0
>>   RCU nest depth: 2, expected: 2
>>   CPU: 1 UID: 0 PID: 31 Comm: ktimers/1 Not tainted =
7.1.0-rc5-00004-g85f7c8ee247a-dirty #3 PREEMPT_{RT,LAZY}
>>   Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
>>   Call trace:
>>    show_stack+0x1c/0x38 (C)
>>    dump_stack_lvl+0x58/0x78
>>    dump_stack+0x14/0x1c
>>    __might_resched+0x128/0x168
>>    rt_spin_lock+0x34/0x180
>>    __wake_up+0x2c/0x70
>>    pps_event+0xdc/0x2b0
>>    pps_ktimer_event+0x44/0x80
>>    call_timer_fn+0x34/0x2d0
>>    expire_timers+0xcc/0x228
>>    __run_timer_base.part.0+0x18c/0x1a0
>>    timer_expire_remote+0x40/0x58
>>    tmigr_handle_remote_cpu+0xb4/0x278
>>    tmigr_handle_remote_up+0xdc/0x270
>>    __walk_groups_from+0x3c/0x98
>>    tmigr_handle_remote+0x8c/0xc0
>>    run_timer_softirq+0xa4/0xb8
>>    handle_softirqs.isra.0+0x100/0x3f8
>>    run_ktimerd+0x58/0xa8
>>    smpboot_thread_fn+0x204/0x338
>>    kthread+0x128/0x150
>>    ret_from_fork+0x10/0x20
>>=20
>> The lock isn't part of the lifetime of the pps_device object, so I =
think
>> fixing that really is as simple as not holding the raw lock across =
the
>> wakeup, something like below?
>>=20
>> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
>> index dc7fac75ec27..f85929d01e3d 100644
>> --- a/drivers/pps/kapi.c
>> +++ b/drivers/pps/kapi.c
>> @@ -203,17 +203,16 @@ void pps_event(struct pps_device *pps, struct =
pps_event_time *ts, int event,
>>=20
>> captured =3D ~0;
>> }
>>=20
>> pps_kc_event(pps, ts, event);
>> + if (captured)
>> + pps->last_ev++;
>> + raw_spin_unlock_irqrestore(&pps->lock, flags);
>>=20
>> /* Wake up if captured something */
>> if (captured) {
>> - pps->last_ev++;
>> wake_up_interruptible_all(&pps->queue);
>> -
>> kill_fasync(&pps->async_queue, SIGIO, POLL_IN);
>> }
>> -
>> - raw_spin_unlock_irqrestore(&pps->lock, flags);
>> }
>> EXPORT_SYMBOL(pps_event);
>>=20
>> Thanks,
>> Calvin
>>=20
>>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>>> index de1122bb69ea..75eb7973e37c 100644
>>> --- a/drivers/pps/pps.c
>>> +++ b/drivers/pps/pps.c
>>> @@ -106,12 +106,12 @@ static long pps_cdev_ioctl(struct file *file,
>>> case PPS_GETPARAMS:
>>> dev_dbg(&pps->dev, "PPS_GETPARAMS\n");
>>>=20
>>> - spin_lock_irq(&pps->lock);
>>> + raw_spin_lock_irq(&pps->lock);
>>>=20
>>> /* Get the current parameters */
>>> params =3D pps->params;
>>>=20
>>> - spin_unlock_irq(&pps->lock);
>>> + raw_spin_unlock_irq(&pps->lock);
>>>=20
>>> err =3D copy_to_user(uarg, &params, sizeof(struct pps_kparams));
>>> if (err)
>>> @@ -142,7 +142,7 @@ static long pps_cdev_ioctl(struct file *file,
>>> return -EINVAL;
>>> }
>>>=20
>>> - spin_lock_irq(&pps->lock);
>>> + raw_spin_lock_irq(&pps->lock);
>>>=20
>>> /* Save the new parameters */
>>> pps->params =3D params;
>>> @@ -166,7 +166,7 @@ static long pps_cdev_ioctl(struct file *file,
>>> pps->params.assert_off_tu.flags =3D 0;
>>> pps->params.clear_off_tu.flags =3D 0;
>>>=20
>>> - spin_unlock_irq(&pps->lock);
>>> + raw_spin_unlock_irq(&pps->lock);
>>>=20
>>> break;
>>>=20
>>> @@ -193,7 +193,7 @@ static long pps_cdev_ioctl(struct file *file,
>>> return err;
>>>=20
>>> /* Return the fetched timestamp and save last fetched event  */
>>> - spin_lock_irq(&pps->lock);
>>> + raw_spin_lock_irq(&pps->lock);
>>>=20
>>> pps->last_fetched_ev =3D pps->last_ev;
>>>=20
>>> @@ -203,7 +203,7 @@ static long pps_cdev_ioctl(struct file *file,
>>> fdata.info.clear_tu =3D pps->clear_tu;
>>> fdata.info.current_mode =3D pps->current_mode;
>>>=20
>>> - spin_unlock_irq(&pps->lock);
>>> + raw_spin_unlock_irq(&pps->lock);
>>>=20
>>> err =3D copy_to_user(uarg, &fdata, sizeof(struct pps_fdata));
>>> if (err)
>>> @@ -281,7 +281,7 @@ static long pps_cdev_compat_ioctl(struct file =
*file,
>>> return err;
>>>=20
>>> /* Return the fetched timestamp and save last fetched event  */
>>> - spin_lock_irq(&pps->lock);
>>> + raw_spin_lock_irq(&pps->lock);
>>>=20
>>> pps->last_fetched_ev =3D pps->last_ev;
>>>=20
>>> @@ -294,7 +294,7 @@ static long pps_cdev_compat_ioctl(struct file =
*file,
>>> memcpy(&compat.info.clear_tu, &pps->clear_tu,
>>> sizeof(struct pps_ktime_compat));
>>>=20
>>> - spin_unlock_irq(&pps->lock);
>>> + raw_spin_unlock_irq(&pps->lock);
>>>=20
>>> return copy_to_user(uarg, &compat,
>>> sizeof(struct pps_fdata_compat)) ? -EFAULT : 0;
>>> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
>>> index aab0aebb529e..f2fe504071ed 100644
>>> --- a/include/linux/pps_kernel.h
>>> +++ b/include/linux/pps_kernel.h
>>> @@ -59,7 +59,7 @@ struct pps_device {
>>> void const *lookup_cookie; /* For pps_lookup_dev() only */
>>> struct device dev;
>>> struct fasync_struct *async_queue; /* fasync method */
>>> - spinlock_t lock;
>>> + raw_spinlock_t lock;
>>> };
>>>=20
>>> /*
>>> --=20
>>> 2.47.3
>=20
>=20

