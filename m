Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A605A21D5B0
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Feb 2026 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347201; cv=none; b=bCFdxXcPxRIDhDmrlfEk+WomHkwlcynsBv/eW8H+hSPBT4eciSCydaiYQXTg4f20BNNjDFs1NbYRdCJ4Nn5vijuhw84gyZY88SQVPTg1VeaFhDSoqK3PZKx5OrEDYZGCTAQs1F6AVkSGrMnBl9WdmaVLycqrtuycP2gYoKlf0H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347201; c=relaxed/simple;
	bh=DTUjvtxX3VM9Ywdq+F5DETu+4ooD7bS3SOw1o22oDpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bCK7BeJJRRqnzJEkgEF/7s38Q0IIl7Y52iGOZYQPQ7fmB0Nns/L5XBtE1Y0vV2/DxL0Y4OtCb0QMeQqeFUjOpTTS+nYJJV9+jkexfHAa3oRytUwqQT9LdY6zdJG+LpTikDg8VZWgBLx4K6FZ8wgbVHKmc7/haoUhpa5TNTDLQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=JBBaHXfT; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="JBBaHXfT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771347169; x=1771951969; i=spasswolf@web.de;
	bh=6B6bjmA2LWx4EtNJZvRrdS+2jf9wBb4Vg2X94UdrU2s=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JBBaHXfTZ6MckhcYpD3jqGdJO1kYS111olGXHf0+C1KMAZZ0rO8z1u94Ybb7rfNg
	 xi7Ii+Jd6jWvrBDSS5otPvdG4LmAlZ72MM2bo4TGbIOcpRQxr33UNlHNovxNi7gdi
	 76/FHwmaROyLeVm2fsfFEF4+f+RFgvjthodrUQZmq3HkqDD4ezSvvq0LaZ0yOQ8as
	 90gogjeAq3cBJKKOFwKON1o6eZ+gcA6eWZVjvMej6xkPXKnJQQEreG20z1kBe/Z6T
	 qA2+DLVRCzHLuDG71kERflH0Qm3zsmtRU/WCcSSaAwq+xI1+MuLUQfpURdoHpHSK3
	 dyuNmBJT3T9KNkd04Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xeb-1vfy421Eqh-00ranO; Tue, 17
 Feb 2026 17:52:49 +0100
Message-ID: <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet	 <edumazet@google.com>, netdev@vger.kernel.org, spasswolf@web.de
Date: Tue, 17 Feb 2026 17:52:48 +0100
In-Reply-To: <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de>
References: <20260216134333.412332-1-spasswolf@web.de>
				 <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
				 <20260216153745.CA3__zRc@linutronix.de>
				 <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>
				 <20260217071952.WCXLGs5-@linutronix.de>
				 <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
				 <20260217095700.SjYjM8RO@linutronix.de>
			 <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
	 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VNueBJLi7+C4SvJhPiiu5lUUE2TRosSISCXzE3rYIZgoqaPG1wc
 sICl2R2xMU4d65YMBc6LCEJuHMH5LMeDDZvFHaFicbzHvwn8bqool13SibsfRXxq+kFxYr5
 d2/7f+7lrATZH8sqS3wkEQqmIXFWrPyfO2y3hzoMatwu1ukR5g6FU0pgw74feBqpk1ikA47
 5R6lGanGiK6j6cM7JIp3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JACKPkEq/9Y=;lWgyLJHsHZZ4or8MFYsfBp+aoAA
 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

Am Dienstag, dem 17.02.2026 um 12:24 +0100 schrieb Bert Karwatzki:
> Am Dienstag, dem 17.02.2026 um 11:42 +0100 schrieb Bert Karwatzki:
> >=20
> > I just wondered if we can completely skip the
> >=20
> > 	if (READ_ONCE(txq->xmit_lock_owner) !=3D cpu) {
> > 		[...]
> > 	} else=C2=A0
> > 	{
> > 		/* "Recursion" alert */
> > 	}
> > =20
> > check, as the synchronization will we provided by HARD_TX_{LOCK,UNLOCK=
}.
> >=20
>=20
> I thought about that again, and it seems like a bad idea as (in the non-=
preempt) case
> other threads trying to access the queue would wait for the spinlock to =
be freed, perhaps
> one can just change the code like this:

My argument above seems wrong: In the non-preempt case we cannot have anot=
her thread accessing the txq
from the same CPU if the lock is taken (it is not preemptible) and for oth=
er threads
accessing the txq from different CPUs the check (txq->xmit_lock_owner !=3D=
 cpu) would succeed
and they would try the spinlock anyway, So this would not speak against ki=
lling the lock owner
check. As for the recursion detection, perhaps dev_xmit_recursion() is eno=
ugh?


Another Idea (more vague ...):

Using the CPU Id as the lock_owner seems to make sense for locks that are =
not
preemptible (raw_spinlock in the RT case). For preemptible locks a thread =
ID (which one exactly I'm not sure ...)
would perhaps make a better lock owner ...

Bert Karwatzki
