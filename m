Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF13DB328
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Jul 2026 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847102; cv=none; b=OsK9n2tfVMem0hnOHQCVted+3+vx4KfF5CO5x0DYbCV36v/83KJSc1ZVEQFp0XoevNRKt9ctrPPvlngi8J8t2FjWs0f8IkFES5nhIQCEsys1WrLLSTwHeTWtAJGyZwmL0CxMWoOC4ZPiBRBV9QpA4yUgpVD9/f8R+FO0Kt0NQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847102; c=relaxed/simple;
	bh=wzyumeaKbuqqTbtsC17CmUJz30QzeufvXy7FOjdaQGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jdp0yyvt/gtPVSJp7/0r92MW2PJYpm4GqonihYMYQt3jTqazN7LxrVUNmykcE6R2J08+U5YhabShARNt4H1AAf66jUYMFbgXeptirKZcXP+lcKdZV1aHSjzQaVOmYH83ObczGtQq1v4DB7q0rLUjPjWNOg98gAXHeIs8yd8XoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=cB1xSMpw; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="cB1xSMpw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784847080; x=1785451880; i=spasswolf@web.de;
	bh=wzyumeaKbuqqTbtsC17CmUJz30QzeufvXy7FOjdaQGM=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cB1xSMpwuLaIEItUY5H2Wyefab7O8/yqJbZWpJiJA+twCyLiGxDHg5NLHT6hmeg8
	 L02KFCdlmq/lLO7OWG9J9PpDHEOX63ZhSHeCtcl7avLb0r7n0+cHoHKqpkm0m3qd8
	 RkonM3Z4mD9ljvGfdo1FI+iDCeMevSNFpZz42OtKJopJOvzlnTs4un938j5uy1aed
	 /sftUcxK8DdgIUREhXQUU5lHnIzRnM/OEtPYL09icAlZGrQwxHxaqmXTp5iA5N0WI
	 z3jYAgIAaI17RnaK4qLzUpAijNSqypu5Uh/NmRAv0k4DKS3/MQA9t/IFK2dzmkURz
	 76ri7icepQzpEQG90g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6lX-1xBy0F1Mhb-00zdSz; Fri, 24
 Jul 2026 00:51:20 +0200
Message-ID: <4d7c2dd588cd77d1d112da473f2a262d22051d57.camel@web.de>
Subject: Re: [Re] kernel panic during shutdown in  next-20260722
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org, Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner	 <tglx@linutronix.de>,
 spasswolf@web.de
Date: Fri, 24 Jul 2026 00:51:19 +0200
In-Reply-To: <1a0800888c2fcd42f1fcd661d8f6f50580ac2fd4.camel@web.de>
References: <20260723131001.11565-1-spasswolf@web.de>
			 <d24a136539c5931984f4855ad6596ca7aee8ebe2.camel@web.de>
	 <1a0800888c2fcd42f1fcd661d8f6f50580ac2fd4.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VlyCl2HRhbixJ6VEUvSQPjND0W/G3vzyzbHtRPfrLf2d8lyyXFz
 HDEe2L/qUgFvVFHKaIFORSAaMx/zTBEhbqk9sDDwvf8GWbV8+E883J1Ej2lt2sjo8NYIEMJ
 IvzurlzeNfkoFWjp3f37gcc740WpflQJYfcI72lFdMG+UXaMg+4K9NZPapqgqT03D9iaQtn
 hJgDpPyyexqEhkx53LZRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+Xw1Lx6sx1E=;04TITx2Ssql5z69tZR5SyfWicKH
 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
 lrIja5itcgTg3MtdirHAr81CBlYgSc

Am Donnerstag, dem 23.07.2026 um 18:17 +0200 schrieb Bert Karwatzki:
> Am Donnerstag, dem 23.07.2026 um 15:23 +0200 schrieb Bert Karwatzki:
> > Am Donnerstag, dem 23.07.2026 um 15:10 +0200 schrieb Bert Karwatzki:
> > > I was able to gather the panic error message from a failed shutdown =
via netconsole,
> > > this time the kernel used was v7.2-rc3:
> > > #
> > > Bert Karwatzki
> >=20
> > Unfortunatetly I can now reproduce these kernel panics in v7.1:
> >=20
> >=20
> > So now I'm going to use memtest86+ on my machine and then look at the =
changes I had in
> > my userspace as the first error occured on 22.7.2026. Let's hope this =
does not escalate ...
> >=20
> > Bert Karwatzki
>=20
>=20
> But I found out an exciting thing:
> I can only reproduce the crashes in v7.2-rc4 when watching the reboot vi=
a netconsole,
> without netconsole no crash occurs!(This also explains why I had not see=
n this crashes before ...)=C2=A0
>=20
Actually this is not cause by netconsole, but by rebooting right after a c=
rash. Some
broken state seems to be preserved across reboots. Switching off the power=
 supply after
a crash or even a ~30s wait after switching off the crashed machine seems =
to be enough
to get around this.
 Also the hang when rebooting next-20260722 also occurs when compiling wit=
hout PREEMPT_RT.

Bert Karwatzki

