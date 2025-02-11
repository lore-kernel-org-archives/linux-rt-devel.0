Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D939257AE0;
	Tue, 11 Feb 2025 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289065; cv=pass; b=TgxMNhVf08G/t3RLHiSiZ47dbgpUyMzf3J45Z/GpB29QKAzrGzVSsEwuibq3IY03zPjTGhN0b8uX8kn/1m5dqCmGczynTRfnnWoO0zrW8AMlxiMRBX1yC4pyEPt882+oWLfDOZD6L5XcNexY0OQmMzGGAjGom2i9IDHVZ4iOBwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289065; c=relaxed/simple;
	bh=s0AsPq4RwJR2+33PXRlQ8dEh5CuInqzkdkunwYbmKC8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kan8TjsPgTdjOkIEBwwMDQNXzbnbAEI86bVWbirra5rO8aHU70Ak7czjHvt6QUtEW9LVNumwYWF52BQEoaqTGkJT3o/KILpMlduv4IjIxBYIhdU9DUxOyPY+lTgsYb/a1n48buqGBzGnTAIBq/A6tX6BWRSC6jOfPKHRVISJPes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=MjPgOei9; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="MjPgOei9"
ARC-Seal: i=1; a=rsa-sha256; t=1739289048; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZuBDVEGmslDdXqhKaV2iIntb0moYczBI9NQEY6Z6jUOL03OFwIYtSeD8do/LBLnIg39LoUKxDCgnHjFc5O+x4LPUTG+/+zp4QM+YJSo6eJ8Ev1mNfTNRCb7nb15Bn2SJro5HFdjD67RlZJrv6SXGzLT6yaDQ6BM2cKtWytuoCZc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739289048; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ynkLWceI6NKQ/gkDqb5Yj4PQr/Nl+gQGLJR+DRzkaMs=; 
	b=jwnskG3FVGXh74McvVCOzyxrY9THmslv2zIxEx2WIsg4hplORLfi6dWufkgIDvgf/erQgZMP+T9JEFh5AVvVVtpC43p2la6x3DwvgRkPbxgC1i4b5HZazTEVN2Mg71aaxac3I9dGWhlVEuCFmuHgG6t2Pqf+x41V2AD9pbEyj7k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739289048;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ynkLWceI6NKQ/gkDqb5Yj4PQr/Nl+gQGLJR+DRzkaMs=;
	b=MjPgOei9CWQlbOw7Vkf3KGA4FQvtbZcX7ftapLJ+P6s7N24lU9FbOSl3rMp4FUPE
	lx9DV9jI7gMeU2Ehkzv1pUDpSkvVZW34asTc+2m6Q445qjlinbKRH47gRtwqInEQjs4
	DkXS7BQh21uyodyqzUnaR5axBku1slFctNFC45q8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1739289047127225.90196701042169; Tue, 11 Feb 2025 07:50:47 -0800 (PST)
Date: Tue, 11 Feb 2025 12:50:47 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: "kernelci" <kernelci@lists.linux.dev>,
	"linux-rt-devel" <linux-rt-devel@lists.linux.dev>,
	"stable-rt" <stable-rt@vger.kernel.org>,
	"Daniel Wagner" <wagi@monom.org>
Message-ID: <194f5b4b029.e5ee4014194612.536900249866001318@collabora.com>
In-Reply-To: <20250211152018.sK91dh93@linutronix.de>
References: <20250211090511.xeFJVnH_@linutronix.de>
 <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com> <20250211152018.sK91dh93@linutronix.de>
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

Hi Sebastian,


---- On Tue, 11 Feb 2025 12:20:18 -0300 Sebastian Andrzej Siewior  wrote ---

 > On 2025-02-11 08:33:56 [-0300], Gustavo Padovan wrote: 
 > > Hi Sebastian, 
 > Hi Gustavo, 
 >  
 > > Thank you for your email. We are happy that KernelCI is helping you with tests. 
 > ;) 
 > >  > Since PREEMPT_RT is now available upstream, would it work to compile and 
 > >  > enable some of its tests for the supported architectures on Linus' tree 
 > >  > and maybe the -next tree? I don't think that happens at the moment, I 
 > >  > saw only a few stable-rt trees. 
 > > 
 > > https://github.com/kernelci/kernelci-pipeline/pull/1010 
 > > 
 > > This will get it enabled for mainline and next. Allow us a few days for processing and 
 > > deploying this in production. 
 >  
 > Sure. Just poke if you have something to inspect or look at because of 
 > $reason. 
 >  
 > The architectures, that support RT are what you see in 
 > | git grep ARCH_SUPPORTS_RT arch/ 
 >  
 > so this does not include arm at current stage for instance. So in 
 > general, if you can't select CONFIG_PREEMPT_RT you can skip the 
 > config/ build/ test. 
 >  
 > RiscV on the other hand is supported.

Right. Let me look at how we can limit this to x86 only.
Unfortunatelly, we don't have much RISC-V hw support in KernelCI yet.

 >  
 > > Beyond that, we would love any feedback you have to us. A lot of the infra 
 > > we have today is new, so there are still rough edges to work on. 
 >  
 > Sure. How do I see easily what is tested/ done? I could maybe wait a few 
 > days and check the dashboard. The link from above showed timerlat has 
 > been but I didn't manage to figure what has been. I guess there is a 
 > script somewhere handling the logic. 

That is one the current limitations in the dashboard. The CI systems are not sending
a clear signal yet that they completed all tests they wanted to run. They just submit
test result individually as they get finished. 

Imo, it is a priority to fix this as it is second time this week I get this feedback.

Best,

- Gus
