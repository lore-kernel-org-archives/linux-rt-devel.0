Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490731;
	b=DO39mRpicSRQ3wbA3w7joGgxLc8g11ZsOOFJejyHsZmOby6yQKeO6PsSRUFjJLFsBhIA
	 qzFvqiSie81ljO5ynWm0Ues1qor0oHxGvjy8vVqjKZZnUVKTHXwcEC1BdOxkrqJJqjA+t
	 9KGGmE0DWEn6SIOVcprzTkvt0OVedry+xCoyTHOfAEGTZQ+9r5zsIhIBGPeYUtk3nWaBV
	 bcswRquCtwBrkC3r2oiEOFFQSvq1IYZpEIHeRvJ9ZI1tA1WG92r0qE4n+A67tuI/YPakP
	 v57GwYjIiydDAOGziLgzfU/mVvNxCARqAlzggUHqLoRZKLDgSNhSbjJRRDFcA3+Kylg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490731;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=qItBt+DFgWhv1B9ZYISs8CvA8pwyeh2Gsl39HWiVk3k=;
	b=XYix/G4jaMWixK6Uh6MZTeYfrsRN1SUs6hZPZgnh0a7pw50j8APLx50QOt/j8zwPBVSr
	 O/mpbmej2fsV8sBjwXRCPh2+tC4+7J876P7jVYFWkFXt0UjbBiaMybopy3Rnk//nIDSbu
	 VOD6owm3rRxyKEsPYvFwNTCVyNn0VPZogGSQhyq6cTnNiSElZHSzfcK7pUMJVcLmadM30
	 HiDXBlR+PEmIHQeRxF+jw5SnGET8PWwVvoN1VKL8j1Cbr9V7l91L/6xrpFNPHbNJqW8KX
	 7RATuZeXG2pz1RVCfkw9Zysvinw20eFYWMLEzeEHMJ4BU0alU9Di409UWh04R0yRQdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=oGlkVURa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GJN759Vn;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05931606A31B
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 10:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05931606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=oGlkVURa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=GJN759Vn
Date: Tue, 20 Oct 2026 12:05:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792490727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qItBt+DFgWhv1B9ZYISs8CvA8pwyeh2Gsl39HWiVk3k=;
	b=oGlkVURaFhoWiffZRqZp1jTkdTdBA5BVtziSWh4+/g23wdR8F2c8tEramFdEJXIK3mdczG
	FEr7tbuuUchw00Jy73ezr/1b8Y2321LTA7Q30tR6+H8e4riDCVj2MAzFrdfU/4fPhppxs1
	53XK8RLCXhKbXHFkwsnpuWxAdNstOdex1hIdoQWLqJM3FSoOcR7RmqNudChf5q76Y+2hBZ
	KcqWBy8okgxRHirvpwrNZKvPvplHZ96AATFSKDvkAIADiPhOgmB+DvUTrbX37KzuBaEfaR
	v6+zlF3LBf1obSOiOWeGlpOllbnxPd0ySCc+IfN2cBCdOuV9+T2Oyjk4+1an0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792490727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=qItBt+DFgWhv1B9ZYISs8CvA8pwyeh2Gsl39HWiVk3k=;
	b=GJN759Vn2D8oORGwaNgtfecfV8I24YsXeleSX9SOS5cios2E02MvQkVQ1c6VkD6wUK6FQW
	MUYFshEjzmLv/6Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.18.57-rt9
Message-ID: <20261020100526.bFEM4NFd@linutronix.de>
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

Dear RT folks!

I'm pleased to announce the v6.18.57-rt9 patch set. 

Changes since v6.18.57-rt8:

  - A printk related change was merged upstream to workaround a Hyper-V
    related freeze on boot. Patch by John Ogness, reported by Derek
    Barbosa.

Known issues
    - Yoann Congal reported a bit spinlock in dm_exception_table_lock().
        https://lore.kernel.org/all/Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local

The delta patch against v6.18.57-rt8 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/incr/patch-6.18.57-rt8-rt9.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.18.57-rt9

The RT patch against v6.18.57 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/older/patch-6.18.57-rt9.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.18/older/patches-6.18.57-rt9.tar.xz

Sebastian
