Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D76A202C36;
	Fri, 18 Apr 2025 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744988751; cv=pass; b=FTXZ6+qXyZI83Ay4EB6Rx9I2ftjy6shZr+154aIGbV9Z30gklfUrOcXYBw6BOGKJZOx8MIY+cz889c3OzrvGUZ3YnNrIBhQKZZancA3aLlKKQV3B277GKKC2T+Z0LU2y4DbcAJfBqLMpA3I0al1AvGuAlMhbl4rnwJEYJqmdn7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744988751; c=relaxed/simple;
	bh=kYK53vgf3Gxgh3NrxiKB2oe/cE9e3gPPkHdTFhWZJ6M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Uc+RaaJ0KY4xAChfmHjFS0I3MnSbnf+iDE4cp6Ig3AwO8gDiWLJWgyQDaa1a3oROOkQIwOya7Dep0uQzGPbuJfLFjXVHoQD7xT7hYg4QrMfAf/aNNHpA6Bi3i9nV52V+H8xbuokJg6cwUVS+E4JO9fxz9GcamPeOxo43qH8LpW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=kmCbxyws; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="kmCbxyws"
ARC-Seal: i=1; a=rsa-sha256; t=1744988737; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BM0amRTvqvZagPYRw1g60C5nY4PAXvdmatzCUo/FwlMVFdNq0k9QmiSo4husKEuSn8QFKfJz5YSXVCxk7tOSHbw6q0nHNJQDN3Qyj/AyVzD7AYVMM0JZD7EQPYPf1PFtKIFD+N3+FS7i4zrdUK+nIOF7EdUDLU9vHEd4RBYAIN0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744988737; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Mlcb9GTu4Ko1EG4fpypORSwh8YyrHUT6FQ8NqDCHIV8=; 
	b=IRdsz5aVKXK/abV8lfJyfM6vCf+4p0xZIU9TDtbDACEAYLaaX5HPu5mVBYYRdSweDWd5Amm7SPi0L0HLKx+K70e00joTeezz9c2KpJQUoMYCz50PGhXQVGrurBOB0GQiMLIvw/brCpjW1uRylT3JYQoBB/HuZarVsVceEcInxHY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744988737;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Mlcb9GTu4Ko1EG4fpypORSwh8YyrHUT6FQ8NqDCHIV8=;
	b=kmCbxywsIFZC9SYepHFva9pHT6nUe31g3kTCW24AFaIeecZCja6S4e8craA3Avcv
	oH+lw9fDMatQKLjsu1ASpxv0P2t4qN691vEqXwzjQO6/CjRJ/BcMHT0Zuk4TpQgkD2K
	/4hm2fzs+ycAsHJPPsRbLMXT8lsk+Pcm+w92SeYA=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1744988735829632.1218085959247; Fri, 18 Apr 2025 08:05:35 -0700 (PDT)
Date: Fri, 18 Apr 2025 12:05:35 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: "kernelci" <kernelci@lists.linux.dev>,
	"linux-rt-devel" <linux-rt-devel@lists.linux.dev>,
	"stable-rt" <stable-rt@vger.kernel.org>,
	"Daniel Wagner" <wagi@monom.org>
Message-ID: <196496f093e.e656f40064825.6229534852937712238@collabora.com>
In-Reply-To: <20250417151113.W9MG8dy3@linutronix.de>
References: <20250211090511.xeFJVnH_@linutronix.de>
 <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com>
 <20250211152018.sK91dh93@linutronix.de>
 <194f5b4b029.e5ee4014194612.536900249866001318@collabora.com>
 <20250213085256.nhWptGL3@linutronix.de>
 <20250411194432.pwc6U7Ds@linutronix.de>
 <19634ddfa6f.10623b4b6827067.8120388710582651736@collabora.com>
 <20250417100410.zxlZCBp-@linutronix.de>
 <19643df8092.ac2e879d858176.2114269254543526159@collabora.com> <20250417151113.W9MG8dy3@linutronix.de>
Subject: Re: PREEMPT_RT testing on kernelci
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail



---- On Thu, 17 Apr 2025 12:11:13 -0300 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote ---

 > On 2025-04-17 10:10:43 [-0300], Gustavo Padovan wrote: 
 > > 
 > > 
 > > ---- On Thu, 17 Apr 2025 07:04:10 -0300 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote --- 
 > > 
 > >  > On 2025-04-14 12:14:44 [-0300], Gustavo Padovan wrote: 
 > >  > > Hi Sebastian, 
 > >  > Hi Gustavo, 
 > >  > 
 > >  > > In my understanding you want to know when results for any rt-tests change status (eg PASS -> FAIL or 
 > >  > > vice versa) for a selection of trees (eg mainline, next, etc). Can you confirm? 
 > >  > 
 > >  > The results change is definitely interesting. The other thing is what is 
 > >  > tested and how. I remember you added/ changed some architectures for the 
 > >  > RT subset. I also assume that warnings at bootime (as in lockdep or 
 > >  > general warnings) are reported. 
 > > 
 > > We have some support around that, but this work is still evolving. 
 >  
 > Okay. 
 >  
 > >  > I remember Daniel asked for some cyclictests/rt-tests integration so I 
 > >  > don't know what is tested here ;) 
 > >  > 
 > >  > From the commandline you sent that there are a few boards running the 
 > >  > cyclictests and everything either passes or is in state "INCONCLUSIVE". 
 > >  > So this looks nice. 
 > > 
 > > Okay. 
 > > 
 > > As for notifications, for which trees/branches you want to see it? 
 >  
 > Linus' master and the -next tree would be good. If you plan add to add 
 > Cc here, it would be nice if you could add linux-rt-devel@lists.linux.dev 

Sounds good. Let me look at how to enable that in the coming weeks, as 
today we don't support report "profiles"  for a given tree.. Eg, the mainline
report comes with all the tests[1], but that would be noise to you.

[0]  https://groups.io/g/kernelci-results/message/58797


Best,

- Gus


