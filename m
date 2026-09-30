Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BF93A7820
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750005; cv=none; b=dyfcEue8Hah4eykTNDV1VOYWXGazw3rdn6n47AhP30KTFkZLfEtRfJwFIuVY8a/Y3PJlgjI3Q4wDx/zyh5w3UVkzNnrMupsaHm2PrYbQdgBm6x1z8nswZxjOUjDDNoejmY6aAn5vdH8ykSjo3Pk0gkaTgbWLJ3tER5XGxHRYbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750005; c=relaxed/simple;
	bh=elQ20eOpdEdO4XcUIyRxsRz7ga6xApYFJYeksfli8MU=;
	h=From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-Id:Date; b=cyAyolIpMzLzIjy+kyvQWACpP3AP7gQ499jT8d/rJe32BsSi56mMC2uTycUnTe93WezannVoMhjwSUSSHUQIkc3pdVlmmNXD0DQRCDz4oCLlYR4ZQoJUCGAucJf6LVJdySKFEzo8AdkPWABTXaCB7stze9e3XSZGkyhK1gxGJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jwbek1Vc; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jwbek1Vc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:MIME-Version:Content-Type:
	Message-Id:Date; bh=elQ20eOpdEdO4XcUIyRxsRz7ga6xApYFJYeksfli8MU=;
	b=Jwbek1VcaFtiK7tjojvyPCuWaeGwfjUIJPcUtaDCzBamT0WTgivzTpCHw4wy3d
	rq5La+gVlZHuz3h4tnm9WATcRTrpQwuAd70nkBCEnytaK6JvIgXcQHaxc9awgU4Q
	ofaZ3RdebhK8hvx3rDih4hyK1KwY4n9JPv/F35/t3XL0Q=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/proxy: Correct the SCHED_PROXY_EXEC dependency comment
In-Reply-To: <20260930062554.2AwbY2nX@linutronix.de>
References: <20260930025824.79296-1-quchaosheng000406@163.com>
 <20260930062554.2AwbY2nX@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V4IMrbxqyeFZBw--.51754S2
Message-Id:<6ABCAD0D.07A826.00008@m16.mail.163.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RKD7TUUUUU
Date: Wed, 30 Sep 2026 14:32:45 +0800 (CST)
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4w04rWq8rQ3XHAAA3G

Understood, and you are right that the existing line reads fine for the
audience it is written for. I was reading it as a developer note about when
the dependency can be dropped, which is not what it is there for.

Dropping it, the patch is withdrawn. Sorry for the noise.

