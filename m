Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8564331218
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Feb 2026 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255959; cv=none; b=RAy5DQKiIIUhEMfVNSjiHIvZMa6BLYbExeTLjGlFfAZDy/oKtqRkh+KFVmBo1weEhTSlNX8qQ4wKp5Xnt8AWR1nmD5PZjL6mny9+Rs67Jhnb79q/7PhWcd/LKedcaXr+71goblzdiAjR+b5/F9Bguk+3xEktwxavHSweZOTUzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255959; c=relaxed/simple;
	bh=WT7afAY0p/skFXA+o85rZU1IJqz/Bey7gNUA3anxr8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCFl4KEoSNEoGeyVKRlKIA8JvQLyiZ4e8qwxMKd8ZDE+fsxpRo4760DV15GJHSNoOf5Dt6m2dK4HUJX/pBm59i+imqUuR4E93mSOqM0cPXTr2k5g5QC0QoTnOVaDvff8rpkR8D5gdOV4YR/VfmhytRBIYQ4DeLc7e2xfyWblUYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=E8yj617l; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="E8yj617l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771255950; x=1771860750; i=spasswolf@web.de;
	bh=WT7afAY0p/skFXA+o85rZU1IJqz/Bey7gNUA3anxr8Q=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E8yj617lrA1USMCTXnJqrbPghjV3+hE4eKY3+PKl0cAGNJmq3xfhRpDoG+Yrq6y0
	 HsQeXeDC4sT+91dzPddotjKnid/9nded0FuOA7sK5R9nh3SwfITZW2XwzoQIHHEiD
	 O/GfZC1h+jDqgN56iDa2kX1zMPt4zCg3SY3hjAtAIVJ+lBccsLWNY82jm1a/6g8/e
	 T7MSA/Vps7C/5WVmDFDW56T5sU4GU16jRx9LYTfQBjFvpPOWbC4B50oCrfZNPExEk
	 bjOX4UkKP4mIztzNFFCVu4uMpwHMybRmqrMflOnNOjlzMgIBlQRmXS8H3J0QFXKeJ
	 YjQu/70SFcNFV2Aapw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pUQ-1vqL5s1pYU-00E0V1; Mon, 16
 Feb 2026 16:32:30 +0100
Message-ID: <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, spasswolf@web.de
Date: Mon, 16 Feb 2026 16:32:29 +0100
In-Reply-To: <20260216134333.412332-1-spasswolf@web.de>
References: <20260216134333.412332-1-spasswolf@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NGSjNYTRQi40X4Iy4radXeQkF69kEAFwvpMI433j+tu2LwY3gye
 54GEXyHsS81OibqGBfBtFElK2e/eND7MXdVweEBAVor6y9/B9Fd2nU9pC3QWl77g5ccefpc
 aYgq8RiZyC0qgZ7PlwJwca8FrcX8aovDK43LT7ZGvbfRKGmxVS7cqmmhr3kr2A5Uged1STA
 r4+OzEpMXNeME4IGUh+PQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W+4414mBnlA=;Si6WO5Y7qUf9W+dnwxzZufSvLYL
 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

Am Montag, dem 16.02.2026 um 14:43 +0100 schrieb Bert Karwatzki:
> Starting with linux-6.18, I see the following log messages
>=20
> 2026-02-15T23:50:17.558716+01:00 [ T1559] Dead loop on virtual device wl=
p4s0, fix it urgently!
> 2026-02-15T23:50:17.558737+01:00 [ T1559] Dead loop on virtual device wl=
p4s0, fix it urgently!
> [...]
>=20
> regarding my wireless network device
>=20
> 04:00.0 Network controller [0280]: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi =
6E 80MHz [14c3:0608]
>=20
> I bisected this (from v6.17 to v6.18) and got this as the first bad comm=
it:
> 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT=
")
>=20
> Using CONFIG_PREEMPT_RT_NEEDS_BH_LOCK=3Dy in v6.18.10 fixes the issue.
>=20
> Bert Karwatzki

May I presume that to fix this properly at least some of the spin_lock_bh(=
)s in
net/mac80211/ need to be converted to local_lock_nested_bh()s?

Bert Karwatzki
