Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E423D3D1D;
	Mon, 13 Jul 2026 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783984629; cv=none; b=XMYSFDCDtSuQJ/Fkb7YXaEI6beItmncSd69s7no5b07ZaOz1CJu5QlxUjzqrFqsXpoCcndbMGrPZxy3JoK+F9s4ZvjUxS6pFHkdn6KoCQxraZexY0L7xuCVjB3xE2yOnBzSHQ9zVxTBL10zp51n2Ef8g3cfXQNS2vMTzzfbS2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783984629; c=relaxed/simple;
	bh=NJ9DaF6JhUSJWaUYB9Rpocopt6/mWJHr2vTjcCNZ4ro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XRRJl8T5ocZqqdfaD+CKUUumPgaUi5BcVGvfhMz3oh1cTfTvZx3RMUQAZhC899GvyGDZk+jj0widrHhf+A66VhIF+TlT8PFujgcozYYgGdqaaLfH82L9en2bqYJagt16r90V5DB/rFGsX9yH6ND/EJUdQSXDd6K4WdetTt1L1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edhk7CZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edhk7CZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70B81F000E9;
	Mon, 13 Jul 2026 23:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783984622;
	bh=/rYGNCeM7epdsW87Q+BmEJkO45GUrKfVPgUWsraJ90A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=edhk7CZMXPJy1JO+YhTaD5EeeQAr3CPW6FmNsud9eIQfX/BNKLaC1Hm8/wwFwBMJY
	 YZuFxHNlAyG/tLhOvq2FiwjSXxVbcREZEJXy/vhKW+SLBp7FHqExSI+1koeGgiiMgT
	 TU7fDhwxW8MvIIOU39FjqmROqy6C8SzB+nA8rYrNvMSG+azFZp/TLa+ux00Re86EWX
	 gk4y7DsAKZeI/s9nxn2PckhvIvKlhuyBE0MYE/iOHkY3lkYvkoXuB1RhSQ/zfkAiHr
	 B5l6DzQTyiKUJmn1kzw4EWfJJpmwlt5LEY9SEQlTa0cintSC6/fLs6sDqdvWwrKqpd
	 dp7ocVKXbkqLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] coresight: Fix scheduling while atomic in
 coresight_put_percpu_source_ref()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Ayman" <mohamedaymanworkspace@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260713230028.8046-1-mohamedaymanworkspace@gmail.com>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260713230028.8046-1-mohamedaymanworkspace@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 23:17:01 +0000
Message-Id: <20260713231701.C70B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Queuing work during CPU idle entry wakes a kworker and sets TIF_NE=
ED_RESCHED on a CPU entering deep sleep, violating scheduler invariants.
- [High] A race condition between atomic_inc() and queue_work() leads to a =
Use-After-Free (UAF) of the coresight device.
--

--- Patch [1]: [PATCH v2] coresight: Fix scheduling while atomic in coresig=
ht_put_percpu_source_ref() ---
commit c63df14eb6cc796f6fe14d3388c86e37be66c857
Author: Mohamed Ayman <mohamedaymanworkspace@gmail.com>

coresight: Fix scheduling while atomic in coresight_put_percpu_source_ref()

This commit fixes a "scheduling while atomic" panic on PREEMPT_RT by
deferring the put_device() call to a dedicated workqueue. It introduces
a put_pending atomic counter and a work_struct to queue the release
safely in process context.

> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtra=
cing/coresight/coresight-core.c
> index 6d65c43d574fd..e931e6bdc84fa 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
[ ... ]
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

[Severity: High]
Can a race condition here lead to a use-after-free of the coresight device?

If Thread A calls atomic_inc() and is preempted before calling queue_work(),
and Thread B then calls atomic_inc() and queue_work(), the worker thread
might execute coresight_put_device_work(), read the combined pending count,
and free the device before Thread A resumes.

When Thread A resumes, would it execute queue_work() using a pointer that
now resides in freed memory?

[Severity: High]
Does queuing work here violate scheduler invariants during CPU idle entry?

Since coresight_cpu_pm_notify() calls this during cpu_pm_enter() with
interrupts disabled, the CPU is already committed to sleeping. Calling
queue_work() on a bound workqueue wakes a local kworker, adding it to the
runqueue and setting TIF_NEED_RESCHED on the current CPU.

Will the CPU enter a deep hardware sleep with a runnable task on its runque=
ue,
delaying the execution of the kworker until an external hardware interrupt
wakes the CPU and breaking the invariant that nr_running must be 0 when
entering idle?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713230028.8046=
-1-mohamedaymanworkspace@gmail.com?part=3D1
