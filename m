Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD12741B7;
	Mon, 14 Apr 2025 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643702; cv=pass; b=RqKnj9nRLd4MAqAQWLSlIzOHW7GbmXKW1lAYCWxKFuM3zQLqhr3rHWSA1F71XpRjDLxchUI1ZDuAiAwuTF5kyHvtZDI1rmOWUz7LhSBgljhEci3KKseUOP4jevAHDw9yh/zu2hTVhtTTeXhzdccm7/hyLdEPoWjrBYmuLvLS46w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643702; c=relaxed/simple;
	bh=779zHdQgvjPvB5gsBJpT4kTT01xhZr/39ofSvNnbjA8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=E3hn16LMaccwIxLrvDhYEGUFD5D+waM8h6kuBy93FIcwHgXJdulI3ZIPBJcoPkiJYsoE7IHrS4HbQ03GQMtITqFIo/NnE2T5ozVLatu0/P2aEN70udmoGfGMiw9Plz/GDncje6WBZw/kqfSgQU/FEWQSOCK1338SbF3vQKPmXwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=gI/1P5G1; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="gI/1P5G1"
ARC-Seal: i=1; a=rsa-sha256; t=1744643686; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GW/xWjT/DmA1SYYHrKURgPK8ypWhee0UyaOEwgHB+pp0A4C88+2uG5a6XwEugqXOl3A9i6D2yGBWuxZLrNGDzXUGvjM1z8A9SOWuABYfhAmq1ub45SjmGAtiXzieu69lFzsoPCPsuSV+fjOlUU4jJPjMVCcN/ASwAGBUjQG1cJM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744643686; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oXxmd5FyrDJtAWBBPAg8BGhUDgpGLs39HcPkGbTMN8Y=; 
	b=Sl/6X1BmGPtz96Wi8D4ugw6f6xNTE1SGbPEeJf113jRzeAhYW7rZYgSRMJ+l+FAyQ+bRBukg3FThBE+YRrbqKmk+kvaa9jf5R+fqYRzd6CsO5gFrS58mDviOGKMxttSfvgiXSD9+bauyh/zryB0SP0a/6e09UxvVAp4xkhF4l4U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744643686;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oXxmd5FyrDJtAWBBPAg8BGhUDgpGLs39HcPkGbTMN8Y=;
	b=gI/1P5G1tfePz5fYVrbIOqpklUmkK3EbljcoXSMFbS25DX7cEYvwyDwINHWJUTuZ
	GLDN1OhpzUu1GXGrNvr7QQxp9ekANYTJpwiN6S3qcBoaKLFYIa1V5oIKDuEAphVRa4b
	pripGdbf0TsLY52Axdz22OcMc1QbLA/AjnY4TG/E=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1744643685001909.8040194772085; Mon, 14 Apr 2025 08:14:45 -0700 (PDT)
Date: Mon, 14 Apr 2025 12:14:44 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: "kernelci" <kernelci@lists.linux.dev>,
	"linux-rt-devel" <linux-rt-devel@lists.linux.dev>,
	"stable-rt" <stable-rt@vger.kernel.org>,
	"Daniel Wagner" <wagi@monom.org>
Message-ID: <19634ddfa6f.10623b4b6827067.8120388710582651736@collabora.com>
In-Reply-To: <20250411194432.pwc6U7Ds@linutronix.de>
References: <20250211090511.xeFJVnH_@linutronix.de>
 <194f4c989de.bdd18d3279996.2067896388251039576@collabora.com>
 <20250211152018.sK91dh93@linutronix.de>
 <194f5b4b029.e5ee4014194612.536900249866001318@collabora.com>
 <20250213085256.nhWptGL3@linutronix.de> <20250411194432.pwc6U7Ds@linutronix.de>
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

---- On Fri, 11 Apr 2025 16:44:32 -0300 Sebastian Andrzej Siewior  wrote ---

 > On 2025-02-13 09:52:56 [+0100], To Gustavo Padovan wrote: 
 > > On 2025-02-11 12:50:47 [-0300], Gustavo Padovan wrote: 
 > > > Hi Sebastian, 
 > Hi Gustavo, 
 >  
 > > > That is one the current limitations in the dashboard. The CI systems are not sending 
 > > > a clear signal yet that they completed all tests they wanted to run. They just submit 
 > > > test result individually as they get finished. 
 > > > 
 > > > Imo, it is a priority to fix this as it is second time this week I get this feedback. 
 > > 
 > > Ah okay. No need to rush. If you have something to look at, let me know 
 > > and I will. Other than that I will lean back and wait for the bot to 
 > > complain ;) 
 > > 
 > > Thank you. 
 >  
 > any updates on this? 

We had some progress, but not enough yet. KCIDB gained support for CI systems to
send when they completed all test execution for a given branch checkout, but we have
to plumb this across this pipeline yet.

Regardless of that, the data is all available in the dashboard and you look up for the 
rt-tests results there.

kci-dev cli - http://kci.dev/ - can also be used. For example: 

 kci-dev results tests --giturl 'https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git' --branch master --latest --filter=filter.yaml

Where filter can contain:

----
test:
  - rt-tests.cyclictest
  - rt-tests.cyclicdeadline
  ...
----

I recommend using latest git kci-dev for the time being as we keep fixing and evolving.
Eg, I just sent a PR to fix a crash that happens when we use the filter file with no hw filter in it.

I also just created an issue for being able to use wildcards in filters. eg `rt-tests.*`
https://github.com/kernelci/kci-dev/issues/163

Both dashboard and kci-dev are pretty young, so features to help the community more and
more are growing month by month. We appreciate the patience and understanding of the community.

On the the above, I am working on our notifications system in the dashboard. You usecase to be cc'ed
on notification for certains tests is not yet support, but we can look at it if we tell me exactly what will 
help you.

In my understanding you want to know when results for any rt-tests change status (eg PASS -> FAIL or
vice versa) for a selection of trees (eg mainline, next, etc). Can you confirm?

Best,

- Gus

