Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5361F463D;
	Thu, 17 Apr 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895459; cv=pass; b=D1ZIkftFThUTSDNvM9TqwexUZRWE0oTLoi2C3M8zjxqqNPrEO4pzMnAwuc/FXscYVYdxLuZe65OPJWC21C/MQNZiHEo5ua16hWtgd/Z/4BGvrjo6hJVmoqsq5CnOcAlIXRn+r9M1RLs/xz8bbyHc5ebphRgXe/5FMx4E1DTy3/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895459; c=relaxed/simple;
	bh=8EaCkBy+lfjfDIVihnAsJ6v4h/9qYPFEAqSzducbRWo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oZz2ugDEMB8PW3B5hp6XwQSd6ufFfEbB7DUGEwt6X9h6zQi8/JNjCqOmZdy0XlrB+Kv2zwBYYl0CSRlMGBZ/X4PLOOMo0Vxb9qiZ/tv1FPgoIAb0CroEpCLFSQZlrZlwaIWVbzR1EkQNy0PdRlhRnVIBvK40egQj4VkRgNhJSqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=RapSgwib; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="RapSgwib"
ARC-Seal: i=1; a=rsa-sha256; t=1744895444; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VohK9JeIpbLhrv6ZAtDYNL1cCwJCc0id9AzX17Iy07+MLq0ozVlxe7Z5jpUMiSTkbWkRSHtshXAuofoK8wu2pDOf+QjT6qB0B4+n9nRrZR9ve0QPpKlwhQDCEHkKqsnBdzJ1XFy4Prbo+s/Pit6KAbQJp7UTjBw6oaQJ2/qmBO8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744895444; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JdgzFf5xo+n7XlCoSvNyi6H4skRHIElcuxjW86zW67k=; 
	b=jodALV9QbtRrNRLPXRBcsCjtZUw9drLTEJliZ8lr23/UPmoaOLy+C3CH3JLea5RV4piHPg+hGNfK8pSMFtM6TXnnI3RJVkTGsJ46kN6ENIt7OGjm4C/3Rg77BuZYfd5omi4HLCqedpi+5vcEueAl3UHRYYVna6HYiocp4UomqhI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744895444;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JdgzFf5xo+n7XlCoSvNyi6H4skRHIElcuxjW86zW67k=;
	b=RapSgwibqYE1LfDihvN7pQ4/eXBdxv4BtxKNQcKxqOa1sMUHxCDq1eOEBncXoNO5
	aIgqjWY1X/YeHXrxjR89GArJ1VBS1tYEHT40foBmQaVqHriOTQ7iZuJFuex+3MnS2MV
	Jy4Dq6EgKCzYdq7tfesPO3H5V2TU3JczXyc2LBXs=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1744895443115255.0566878623447; Thu, 17 Apr 2025 06:10:43 -0700 (PDT)
Date: Thu, 17 Apr 2025 10:10:43 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: "kernelci" <kernelci@lists.linux.dev>,
	"linux-rt-devel" <linux-rt-devel@lists.linux.dev>,
	"stable-rt" <stable-rt@vger.kernel.org>,
	"Daniel Wagner" <wagi@monom.org>
Message-ID: <19643df8092.ac2e879d858176.2114269254543526159@collabora.com>
In-Reply-To: <20250417100410.zxlZCBp-@linutronix.de>
References: <20250211090511.xeFJVnH_@linutronix.de>
 <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com>
 <20250211152018.sK91dh93@linutronix.de>
 <194f5b4b029.e5ee4014194612.536900249866001318@collabora.com>
 <20250213085256.nhWptGL3@linutronix.de>
 <20250411194432.pwc6U7Ds@linutronix.de>
 <19634ddfa6f.10623b4b6827067.8120388710582651736@collabora.com> <20250417100410.zxlZCBp-@linutronix.de>
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



---- On Thu, 17 Apr 2025 07:04:10 -0300 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote ---

 > On 2025-04-14 12:14:44 [-0300], Gustavo Padovan wrote: 
 > > Hi Sebastian, 
 > Hi Gustavo, 
 >  
 > > In my understanding you want to know when results for any rt-tests change status (eg PASS -> FAIL or 
 > > vice versa) for a selection of trees (eg mainline, next, etc). Can you confirm? 
 >  
 > The results change is definitely interesting. The other thing is what is 
 > tested and how. I remember you added/ changed some architectures for the 
 > RT subset. I also assume that warnings at bootime (as in lockdep or 
 > general warnings) are reported. 

We have some support around that, but this work is still evolving.

 > I remember Daniel asked for some cyclictests/rt-tests integration so I 
 > don't know what is tested here ;) 
 >  
 > From the commandline you sent that there are a few boards running the 
 > cyclictests and everything either passes or is in state "INCONCLUSIVE". 
 > So this looks nice. 

Okay.

As for notifications, for which trees/branches you want to see it?



