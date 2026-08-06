Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032334CFCF;
	Thu,  6 Aug 2026 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000577; cv=none; b=sStgL19Vm1Nh3iz5B05qhBJcbIxLXTSK4abkk9wFQK35OaE5xGbY2zWeo9Dr9QEQ6lqLwMnxf5Pe1QdyZpAhpjkiidRLovvwrJckrgqIcnBVEl+GewMCPTVk8XobkiJxFxLp6N6cRtmNvVWVZc7DdMkoGvsszy6m8L2mxUf2gFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000577; c=relaxed/simple;
	bh=ERqUUXbIbeyNBq/9zeHeMeyRQ06qpVridmloXHcDA5A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GdYxnyKrbIiZw9qWpLOOBw6nHthFkx0kzGn1Lme/i4ses+JgDumZH52Ka6ItNpWEli7OgX9PnF/+KP/pK4/5EJQPBVxsUwV+Iw3b4cjXa5jEcn0pkML2EBk6f0Pb279JV7XypNi3LmL9XE5h7ATC/IxdolCUFNjrGiMNE0W/fdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJATT4+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJATT4+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9E11F000E9;
	Thu,  6 Aug 2026 07:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786000575;
	bh=cQFP1f4AmVbWzP8Mg/ijPZrWbFaoRKfmVdZv5HvK5d8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HJATT4+OFwZ6PkrUo/Otd2cSjsWW4WWuxu3QbnrZizjFshLYF4jtYP5LvVptS8xBM
	 Sh+wDr8OYLWCcefi8z7ciHjiFAX8awTO1DbWXtFUyDDzZgU8K5YRiCbA+fI58C1myr
	 0lHLHG1iJo9ZiNwWfKZh9xxKT+Zw95RYDhEdOaI6BEjQw0YKqQuK3zfK7iO7nR06GW
	 LZQ4iY98Ivo+LI+lShPUu0mX5jDy+1K1q1RGbn4I5oi+4tOWaUu5AP+l3wtb5Z209Y
	 0Jo59cl5zvQi/+1rgO3Qo59Sx54zIlZSGW0zLh9AHYn9ibjyDyjyVPEkmXHltBNjde
	 7EaSPlNnOKsXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mailbox: qcom-cpucp: fix PREEMPT_RT self-deadlock
 in IRQ handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Yang" <jia.yang@oss.qualcomm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-1-d302a63dfb5e@oss.qualcomm.com>
References: <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-0-d302a63dfb5e@oss.qualcomm.com>
 <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-1-d302a63dfb5e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 07:16:14 +0000
Message-Id: <20260806071615.6F9E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Dropping `chan->lock` before `mbox_chan_received_data()` introduce=
s a TOCTOU race with `mbox_free_channel()`, leading to a NULL pointer deref=
erence.
- [Medium] Acknowledging the hardware RX interrupt before invoking the RX c=
allback violates the mailbox framework API and can cause client re-entrancy.
--

--- Patch [1]: [PATCH 1/2] mailbox: qcom-cpucp: fix PREEMPT_RT self-deadloc=
k in IRQ handler ---
commit 995d8aa11aed719aa1d45f140bab12a284779e97
Author: Jia Yang <jia.yang@oss.qualcomm.com>

mailbox: qcom-cpucp: fix PREEMPT_RT self-deadlock in IRQ handler

This patch addresses a PREEMPT_RT self-deadlock in the qcom-cpucp mailbox I=
RQ
handler. It prevents lock re-entrancy by caching the channel client, cleari=
ng
the hardware interrupt inside the lock, and invoking the receive callback
outside the lock.

> diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpu=
cp-mbox.c
> index 862e45e8fbd58..0f7fe189e8b1f 100644
> --- a/drivers/mailbox/qcom-cpucp-mbox.c
> +++ b/drivers/mailbox/qcom-cpucp-mbox.c
> @@ -63,14 +63,25 @@ static irqreturn_t qcom_cpucp_mbox_irq_fn(int irq, vo=
id *data)
[ ... ]
>  		/*
>  		 * Provide mutual exclusion with changes to chan->cl.
>  		 * Save cl locally and clear the HW interrupt inside the lock,
>  		 * then invoke mbox_chan_received_data() outside the lock to
>  		 * avoid a PREEMPT_RT self-deadlock: mbox_chan_received_data()
>  		 * can call back into mbox_send_message() via scmi_rx_callback()
>  		 * -> mailbox_clear_channel(), which re-acquires chan->lock
>  		 * (converted to an rt_spinlock under PREEMPT_RT).
>  		 */
>  		spin_lock_irqsave(&chan->lock, flags);
> -		if (chan->cl)
> -			mbox_chan_received_data(chan, &val);
> +		cl =3D chan->cl;
>  		writeq(BIT(i), cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);

[Severity: Medium]
Does clearing the hardware interrupt before invoking the RX callback violate
the mailbox framework API expectations?

If the remote processor immediately sends another message upon seeing this
ACK, could a new interrupt fire and be processed on another CPU while the
lock is dropped, leading to concurrent entries into the client's rx_callback
for the same channel?

>  		spin_unlock_irqrestore(&chan->lock, flags);
> +
> +		if (cl)
> +			mbox_chan_received_data(chan, &val);

[Severity: High]
If mbox_free_channel() runs concurrently and sets chan->cl =3D NULL immedia=
tely
after spin_unlock_irqrestore(), won't mbox_chan_received_data() cause a NULL
pointer dereference?

Even though we check the local cached "cl" variable here, the framework API
unconditionally dereferences chan->cl without locking:

drivers/mailbox/mailbox.c:mbox_chan_received_data() {
	/* No buffering the received data */
	if (chan->cl->rx_callback)
		chan->cl->rx_callback(chan->cl, mssg);
}

Could this race be reliably triggered during channel teardown or client
driver unbind?

>  	}
> =20
>  	return IRQ_HANDLED;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-mailbox-qc=
om-cpucp-preempt-rt-fix-v1-0-d302a63dfb5e@oss.qualcomm.com?part=3D1
