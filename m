Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720570;
	b=cIrQWRHX2P3Ix5JOigiYVwpdEmgyOr+3CQRarRerlMcEsgI4w9U39MJVK2JFd1GVNA5u
	 2PD7q3t4LWSGDHONrDNDqn+1NwieyZQnf2JVcG3Yk8FhVsP0Rm8PH3v0mwM5bPaVCSXID
	 yibAeTtnldTk+BOHEyKGrbGB+5wOJrukST8yuE5QyMbDlMhBkMKpfTIl0lj0EOp8B/mnd
	 6Cack95NMkfZFEh+rXfTGCSV/ObdWHrHdoKIsKIdgP8oV25EHbAfnAUD+j1HQiEQ+9P61
	 v+E6vgMc5w5XicewDa/ct1TgBTqMDYqvlf3AGirqBnRzpWEXD/LnLu8+M0jcQRGJJ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720570;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=wuK7LmgcC7u8EwiAYxopNkKKaHx7rf/5CAdOouqZE3w=;
	b=DijO9YfrJGdX0tgoA5lpv9T101p0tvFqEYwk+HEky2sxuEbVPaMZVT2CkLLzSsG6Jc+m
	 xYfPb0zxz5R8KLm9qE8iCBg2c6RDV//BIfow+KZdT6W0iSlMH+lBJr6DjyHcE+nrTaz4z
	 UUt5MUkyfb4XI9CargUYDY4oI1Qq+m6tjPphuP9RX9PE2mdHH3myfPVslY0INoY9g2K+G
	 S4FmYum4yme4TB2URsLKZ+svFAe97EO1WLrem0Pmhlct+Z5LpDYqALBmLSsIhC3gjaIKq
	 LMbKUkUTDszcSofT+O6seMaxnAfK4SWjJ2tBz7KnhJ2fnL9SPxi9Gs0ZpXf4VHDDPbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=p7irUjyG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="wRGD6VE/";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ABD606D803
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 15:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22ABD606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=p7irUjyG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=wRGD6VE/
Date: Tue, 3 Nov 2026 16:42:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793720568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuK7LmgcC7u8EwiAYxopNkKKaHx7rf/5CAdOouqZE3w=;
	b=p7irUjyGce931pmrKe0HlmEOEKWi5zSVj2OTXAl7IEl9b6Lhvbn1veh158nshUjDv1gebs
	Xw/JOZa75WvcZTNh2l0kyWY2+WJHKP0aT2BaQtiGif3tNLbHx2v4yumRxS+w6P9w8tOmHI
	I4LXXOc/sNDkFaI1eiIBL4olZsoSXByXN0SSuAbFoyl/zZPnp0X88a/D3kebd3bpFdLl9/
	s5t4boyT2LhTSC3uBAWRx+wHNQOeupos4SjN9lY4+5P38/mZBnN7Lg56tg1aBG8RkJw7L3
	knMc8muBRQ/o3WP9sQQmbeLQPUHiaKrn16fKZQDsXBWdGciveB+qgg11KRPRAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793720568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wuK7LmgcC7u8EwiAYxopNkKKaHx7rf/5CAdOouqZE3w=;
	b=wRGD6VE/Vpp6881jDOQDLdqnMy28nj/j0tSyIPjeZ4nX/IoljV9pTJdDxE5UORi0aWARGP
	OT5QtvQLz33d2VCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Enric Balletbo i Serra <eballetb@redhat.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix NXP STM clockevent bugs causing lockups
Message-ID: <20261103154246.S-8NqN99@linutronix.de>
References: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>

On 2026-11-02 22:16:19 [+0100], Enric Balletbo i Serra wrote:
> This series fixes three bugs in the NXP STM clocksource driver that can
> cause soft lockups and missed timer events, particularly visible on
> PREEMPT_RT kernels running on S32G platforms.
>=20
> The NXP STM generates an interrupt only on exact match between the
> counter and comparator registers. If the counter passes the programmed
> value, the match is missed and the hardware must count through all 2^32
> ticks (~32.2s at 133 MHz) before firing, causing soft lockups.
>=20
> Patch 1 fixes max_delta: on 64-bit platforms, ULONG_MAX exceeds the
> hardware's 32-bit compare register width, making it possible to program
> an unreachable compare value.

This looks fine

> Patch 2 fixes the overshoot detection in set_next_event: the existing
> check only detected counter wraps, not the normal case where the counter
> advances past the programmed value during the read-modify-write window.
> Replace it with a signed comparison following the pattern used by
> timer-imx-gpt.

okay=E2=80=A6

> Patch 3 increases min_delta from 2us to 20us: under bus contention on
> PREEMPT_RT, 2us is not enough margin and the counter frequently
> overshoots the programmed value, triggering repeated -ETIME retries.

This all sounds like the hpet trouble on x86. I'm not sure what heavy
busy contention means and why the device is enabled/ disable during
setting. I would assume that the programmed value hits the HW after the
wrap so you wait until the counter wraps again for the equal match.
Worst case would be you read back the expected value but the HW sees it
later (after the wrap).
hpet_clkevt_set_next_event() does in principle the same check as you in
#2 except it compares against the "min" value instead <=3D0.
Would this make sense?

Sebastian
