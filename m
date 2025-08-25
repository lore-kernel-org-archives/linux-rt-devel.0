Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12B393DCC
	for <linux-rt-devel@lists.linux.dev>; Mon, 25 Aug 2025 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090958; cv=none; b=DgLjmQE5s7IU3o4tfnueqviwS5XP8WIqYyxoJ/AtB9BKzXgLjrCRDDe0doRj8+qCzTfx/TLlib7mI0IpEpJKnARkoO8fgUGQEOfc9o744/mBb0ry1hwhUrmYDi9Tfbd/2iYCXm5Oquob92mrc9XN8kt9xkJtBupEJS1Yv4EA+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090958; c=relaxed/simple;
	bh=4EvB5Sl17xLgiHRIcTtMd7fiK41JtouMDEXa8ZRhXSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QKYvdqlcqg0Ntlk4XxQLkCJM2AN7j6fRAuMEViWh9KISqK2i4Xkst8kZ4A0lm6yaZvxTR0mttbas//gHADk6Xuwy+sVuy5XXcxEkfiBYeJPcyoQRxGS4ncGpTD19BNFQIlnvrfzFUqEtwmVL+L9xVtoSMH6GOKuQUIfyV9UZ1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ee08adec815f11f0b29709d653e92f7d-20250825
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:406728a0-26b9-4e5b-a5aa-ff1ba4498ec2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:bda81044142043a00ecf4e221c9a24fe,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|850,TC:nil,Content:0|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ee08adec815f11f0b29709d653e92f7d-20250825
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <cuiguoqi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 425965928; Mon, 25 Aug 2025 11:02:26 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 205FDE008FA3;
	Mon, 25 Aug 2025 11:02:26 +0800 (CST)
X-ns-mid: postfix-68ABD241-930007515
Received: from localhost.localdomain (unknown [10.41.103.97])
	by mail.kylinos.cn (NSMail) with ESMTPA id 2A0E9E008FA2;
	Mon, 25 Aug 2025 11:02:21 +0800 (CST)
From: cuiguoqi <cuiguoqi@kylinos.cn>
To: pmladek@suse.com
Cc: akpm@linux-foundation.org,
	bigeasy@linutronix.de,
	catalin.marinas@arm.com,
	clrkwllms@kernel.org,
	cuiguoqi@kylinos.cn,
	farbere@amazon.com,
	feng.tang@linux.alibaba.com,
	guoqi0226@163.com,
	joel.granados@kernel.org,
	john.ogness@linutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	namcao@linutronix.de,
	rostedt@goodmis.org,
	sravankumarlpu@gmail.com,
	takakura@valinux.co.jp,
	tglx@linutronix.de,
	will@kernel.org
Subject: Re: [PATCH] drivers: example: fix memory leak
Date: Mon, 25 Aug 2025 11:02:17 +0800
Message-Id: <20250825030217.1663575-1-cuiguoqi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aKR-eBMoMBa4fnrF@pathway.suse.cz>
References: <aKR-eBMoMBa4fnrF@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Petr Mladek <pmladek@suse.com>

Hi Petr:
> How did you find this problem, please?
> Were you investigating why a log was missing?
> Or was is just be reading the code?

  When I was developing the Linux real-time kernel, the system abnormally=
 crashed,=20
and kdump triggered the inability to normally enter the second kernel for=
 demsg&vmcore saving.=20
When an abnormal panic is triggered simultaneously, the abnormal scene an=
d some of the jump logs
of kexec are not output, which to some extent affects the efficiency of d=
ebugging and testing

Motivation for the fix:
1. For RT kernels with Kdump deployed, ensure that all relevant informati=
on such as call stacks is fully
output to the serial port during the entire process from panic occurrence=
 to transition to the second kernel,
 which can better enhance debugging efficiency.

2. When Kdump is not deployed, the call stack can be directly output in R=
T kernels as shown below:
```c
vpanic{
+ printk_legacy_allow_panic_sync();

+debug_locks_off();
+console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+nbcon_atomic_flush_unsafe();
}
```

3. Therefore, currently I am wondering whether the issue lies with `debug=
_locks_off();` or if there is an issue with=20
the logical placement of `printk_legacy_allow_panic_sync();`.

My understanding is that by the time we reach machine_kexec(kexec_crash_i=
mage);
other cores should have already been notified and shut down. Additionally=
,=20
since this is clearly an emergency situation, flushing the log buffer to =
the terminal=20
should not introduce further adverse effects.
I would greatly appreciate your insights and guidance on this matter.
