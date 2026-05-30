Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD62EF64F
	for <linux-rt-devel@lists.linux.dev>; Sat, 30 May 2026 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780139015; cv=none; b=rgp5USa/c7W3m0SHyCGgPCzaE7O8dUpz9sTz3silUd6SICiK3kFVnazRTSnz754DcHvngBuhbjBbNZCu19imYVFKA4qt9m3MEdmSubWMgyYU/ugTwrtitUVK+ism38sUyCs6tOEohrchgyq1CeoVYLtqcY8eDiCSkE+wqu0HALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780139015; c=relaxed/simple;
	bh=XTGpZQ4QfJS2q4tKDCC291BuHy7G0ZraP/yLFxF8g7k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BQPOQW8bEptz/3udHaiSPsChs2LgA+C2TlgynitYH0jRDNMa/M9wBV6C2pJgoXiQBJdW0stOrFWtOMPVdlkK4OBmncUzQeukNEckAchAD4x1/ihZDt/HBWfiG0mV1W9UCvIlkdXuKKc8XWHRzUUak1GNq7wkA18OlSThoo8jEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de; spf=pass smtp.mailfrom=by-online.de; dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b=ElQlR2wp; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=by-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=by-online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=by-online.de header.i=by@by-online.de header.b="ElQlR2wp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=by-online.de;
	s=s1-ionos; t=1780139005; x=1780743805; i=by@by-online.de;
	bh=k9n943e+MEekOei5rzaQmIDae3Tq4DBTHSc/EaioPB4=;
	h=X-UI-Sender-Class:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=ElQlR2wpUGue3zL/9Pc9p3dBVo0oWMbt331D1DRx1VOjHiGPha00QHJgLi5uH3z1
	 uhrAUBUneJ1sZsUWt56TKKKvA3WQY/qzOlg81X1Xeh/4HhX3wLWvNrXI+ziPwAKYL
	 0n9vn933M7/+gMhzHzKxXbgdOwKtH3XGCL0oyou5NmDxQezq/QNVhl70FZlcxJ7Kb
	 Sj4SoQlr9YAD7DEvbq0oEtWZs0oQfK0PuAxcAimmZ1KMRW2Pbf07JQGsd33Km7YSb
	 YQlqS+1pefySXKuznMYT71Z8G/wDH0u6zJ4nB1DIfP0aeh7mOl6Cu2iddsISjeMEK
	 Uf9+uclO/S3Dn58cAQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MjSHc-1x8Qlz2CR0-00pG21; Sat, 30
 May 2026 13:03:25 +0200
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
In-Reply-To: <20260529125724.ZaipPjjc@linutronix.de>
Date: Sat, 30 May 2026 13:03:14 +0200
Cc: linux-kernel@vger.kernel.org,
 Rodolfo Giometti <giometti@enneenne.com>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eliav Farber <farbere@amazon.com>,
 linux-rt-devel@lists.linux.dev,
 David Laight <david.laight.linux@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA03756E-F6CB-4E60-B901-E9825F1DD001@by-online.de>
References: <cover.1779733602.git.calvin@wbinvd.org>
 <3fa6ae908b37681ec6857b413179b67a7655c753.1779733602.git.calvin@wbinvd.org>
 <ahXdZFrw79US8MO3@mozart.vkv.me> <20260528074939.7MLrIhrM@linutronix.de>
 <ahhl8dZ-uMM8gmDO@mozart.vkv.me> <20260529071931.nSO7Uqb2@linutronix.de>
 <ahmIp6lEjoiy-EDJ@mozart.vkv.me> <20260529125724.ZaipPjjc@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Calvin Owens <calvin@wbinvd.org>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-Provags-ID: V03:K1:yimdwyE3lyz90z4FR23WUqOaQYNAmbcMkctphoMMG0nmzMjGgFc
 HcQ2M1X8zH5fkO6iJa935CdjdfEpP8XPTzJ91i7FQ8lnqHP4JgV1RHXEHAkGHfQ/3NhpTLr
 +tTMraqXXrriYPY+gVvvgkGVYNz/+MZUrGuP0PweNrNHT5OS9owsuxtFqnrmke4dgpxsRkN
 wcthtaVqxn7QaLsEnKyYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mr5Q/OYAAno=;+TURg8WI513Xz/ypmTVJURn9SwD
 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
 bNXUHp/vkVhPmMSSpi9SM2ArzTxDY=

Hi Sebastian, Calvin,

Thank you both, and you're right on all three points, I should
have caught this before sending v6.

Confirming the analysis:

- pps_event() is never called in hardirq context. After patch 1/3
  the pps-gpio path runs it from the threaded handler; pps-ldisc
  (via uart_handle_dcd_change, under the uart_port spinlock), PTP
  (via ptp_clock_event, under a normal spinlock), pps-parport and
  the pps-ktimer testcase all reach it from threaded or normal-
  spinlock context that would already splat if unsafe. So pps->lock
  never needs to be raw -- patch 3/3 is dropped.

- pps_kc_hardpps_lock is the outer lock; hardpps()'s tk_core.lock
  is the inner one. Taking a raw lock under a sleeping lock is the
  legal direction, and the lock isn't held across anything that
  sleeps, so it needn't be raw either -- patch 2/3 is dropped.

- Patch 1/3 stands alone: it removes the timestamp-capture delay
  that IRQ force-threading introduces on PREEMPT_RT, which was the
  real motivation. Thanks for testing it in isolation.

I'll resend patch 1/3 as a standalone patch (v7).

Best regards,
	Michael



> On 29. May 2026, at 14:57, Sebastian Andrzej Siewior =
<bigeasy@linutronix.de> wrote:
>=20
> On 2026-05-29 05:37:59 [-0700], Calvin Owens wrote:
>>> So lets look at the series:
>>> - #1 splits the handler to take time stamp in hardirq and the =
remaining
>>>  work in the thread. It seems to be crucial to do so because doing =
so
>>>  in thread breaks something. Okay. Granted, makes a bit of sense.
>>>=20
>>> - #2 ignore for argument's sake
>>>=20
>>> - #3 says swap the lock so we can use pps_event() in hardirq =
context.
>>=20
>> I interpreted that as saying "swap the lock so the lock can be safely
>> acquired from code running in both hardirq and threaded context".
>=20
> That is correct. But wake_up_interruptible_all() and kill_fasync() =
must
> not be used in hardirq context.
>=20
>> But looking more closely, it doesn't seem that either lock is ever
>> acquired in hardirq context before or after this series.
>>=20
>> So I think patches 2 and 3 are unnecessary.
>=20
> Okay then.
>=20
>> As a quick confirmation, I tested only patch 1 on a bona fide =
pps-gpio
>> setup with lockdep and atomic_sleep and saw no splats.
>>=20
>> Patch 2 suggests tk_core.lock being a raw lock was somehow a problem,
>> but it's never held across anything, it seems fine.
>=20
> pps_event() does invoke pps_kc_event(). So you need to swap this lock
> (pps_kc_hardpps_lock) before swapping pps->lock. And hardpps() itself
> already has a raw_spinlock_t so it is fine.
>=20
> That is my interpretation.
>=20
>>> Now. Why or where do we need to use pps_event() in hardirq context?
>>> If we use pps_event() is used in hardirq context, as claimed in the
>>> commit message, then dropping the lock early here does not help and =
it
>>> will lead to the same splat in wake_up_interruptible_all() because
>>> interrupts are still disabled independent of the lock here. It is
>>> hardirq-context after all.
>>>=20
>>> You don't see this warning in your testcase because it gets here =
from a
>>> timer, yes. But. pps_event() can't be used as-is from hardirq =
context
>>> either.
>>=20
>> In pps-gpio it's called from pps_gpio_irq_handler() which is =
threaded.
>>=20
>> In pps-ldisc it's called from pps_tty_dcd_change(). That is called =
from
>> uart_handle_dcd_change(), the uart_port lock is a normal spin lock =
and
>> is held over the call, and it calls wake_up_interruptible(), so I =
think
>> that one must be fine (I only looked closely at 8250).
>>=20
>> PTP calls it from ptp_clock_event() which itself takes a normal spin
>> lock, so if that one wasn't safe people would get a splat already.
>>=20
>> In pps-parport it's called from parport_irq(). That is called from
>> parport_irq_handler() and mfc3_interrupt() which both look threaded =
to
>> me.
>>=20
>> In the testcase the earlier trace was from it's called from
>> pps_ktimer_event() which is threaded.
>>=20
>> I don't see anywhere pps_event() is called in hardirq context.
>=20
> Okay. In that case #1 should be sufficient to not delay the taking the
> timestamp if the context switch to the threaded interrupt is indeed =
such
> a problem.
>=20
> Sebastian

