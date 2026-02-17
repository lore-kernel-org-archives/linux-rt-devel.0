Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35255326D5D
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Feb 2026 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324992; cv=none; b=WXjHIli1lsIucqcC/k4jgMPEEHEDdIeeIUg5PsSKzstcqCA46Qra3wg37n0oV4rnelJ85g+08+YnLAUCA2T/RxSSgbOIsNN3gDL4EGpzfSXPwSJrwySg76yxx0A4AJ05yOob/GJ8wE+D6Tt2M4a3DRVq9Qa2oa/hqkF3Hicg0/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324992; c=relaxed/simple;
	bh=OmLKkft9WNiqTnM8Vqp/xdS5RHExqj6MMcor5aRgVaI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2wHqJ6OzTUQQMrn07EQFocYXxHhErfUlzMueAP5JmcW0tI9tTNI7LsXVhdA1chnhztBiiIb1tNCW3PJYk5PmrJ8lP5e/K5DJTd2oYgydkx3Kpwz3q+LtxXMueYCE/au68r4WWym7JAjuwXtfz76Jhzm9vgRnFm4bORDOAE0Tuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=gUCBGY4M; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="gUCBGY4M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771324979; x=1771929779; i=spasswolf@web.de;
	bh=pXpTyFQ18o5ZKXWLKJppGlbe/uhU7Ng58xQAqEZYvQs=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gUCBGY4MuwkhSsdno6dtCWUh7vrgDFHa9L8ie7Uv6If1dI20mMSEMQU+S/msDAuv
	 Kh/vUzoURo133RGSHjLtzcwlHTQRgKCTLSQAXabACS5Cefr3p7XiKXHtn6kRYC+0q
	 i9ZlEmLwu95NMLUKRlzTGgwZdWdSvTE5Qkjf2ihxN9dvtLwRtUBXKntzlFHWDXYqk
	 tlgmTdG0js84l+bpEDGRdaZ0nTzrnrG4PaD6+22iRMAafxhFm1U8RKYP8+lA5dQjP
	 gCz5qBKN96LrINhFUGeVO0Ea/NH8+nQC0p80GA237PWJBfYkRMnmCa9kud0SRYtXs
	 QcK/PdCeyE7QVSZECw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Lg-1vnMKD0rY6-00Aj4x; Tue, 17
 Feb 2026 11:42:59 +0100
Message-ID: <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Date: Tue, 17 Feb 2026 11:42:58 +0100
In-Reply-To: <20260217095700.SjYjM8RO@linutronix.de>
References: <20260216134333.412332-1-spasswolf@web.de>
	 <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
	 <20260216153745.CA3__zRc@linutronix.de>
	 <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>
	 <20260217071952.WCXLGs5-@linutronix.de>
	 <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
	 <20260217095700.SjYjM8RO@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A0ndxEIOhrc2U6g9ZJcw+oqhMVO+ufQTTbiX+uBfH0r3g7oDw6K
 xC7ZvA2k1S3K69JGRwNI9lOwZfbzXJJtjgeKjMIFu6YM7RhkzZUAr0o3QQZfYSlHx9aER58
 /J5FePeLGK3E4HzMss5OV4S3m98ABx3bq0kNzdiqTjDXvETGXJefvNeDqHhHrh6opuDfTX4
 1cQPzg99hafTSsrfVUKhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1fMAT0DwJrw=;VfywNawdsEB61LEo05YJkf0/lT6
 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
 Iz42dy8ebPHPi7u5y1dGlg6wfnYhhjXI8n/rUj

Am Dienstag, dem 17.02.2026 um 10:57 +0100 schrieb Sebastian Andrzej Siewi=
or:
> On 2026-02-17 09:56:48 [+0100], Bert Karwatzki wrote:
> > Am Dienstag, dem 17.02.2026 um 08:19 +0100 schrieb Sebastian Andrzej S=
iewior:
> > > On 2026-02-17 00:48:25 [+0100], Bert Karwatzki wrote:
> > > > The problem seems to be that different preemtible threads try to s=
end skbs.=20
> > >=20
> > > This does not matter because the counter is per-thread not per-CPU.=
=20
> >=20
> > The "Dead loop on virtual device" messages is not printed because dev_=
xmit_recursion()
> > returns true, but because READ_ONCE(txq->xmit_lock_owner) =3D=3D cpu.
>=20
> Ach, so it is not the recursion, it is the assigned CPU.
> This is assigned via __netif_tx_lock(). Here we somehow lack the
> expected synchronisation. So the queue should be locked but not by the
> caller.

Yes, the queue gets locked by the first thread (via HARD_TX_LOCK), then th=
e thread gets
preempted before the processing of the skb is complete, then the next thre=
ad on the same
CPU calls __dev_queue_xmit() and find that the lockowner has the same CPU =
id.

I just wondered if we can completely skip the

	if (READ_ONCE(txq->xmit_lock_owner) !=3D cpu) {
		[...]
	} else=C2=A0
	{
		/* "Recursion" alert */
	}
=20
check, as the synchronization will we provided by HARD_TX_{LOCK,UNLOCK}.

The comment

		/* Other cpus might concurrently change txq->xmit_lock_owner
		 * to -1 or to their cpu id, but not to our id.
		 */
suggests that the case that a thread is preempted while holding the lock w=
as
not taken into account here. And in non-RT cases this would be correct as =
spin_lock()
disables preemption in that case.

Bert Karwatzki
