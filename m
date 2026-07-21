Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA594C955F
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645867; cv=none; b=cQipeCLU4h5IPAJcQFmJ8WJ9jaV3gGmkw2YeTD5ykVrS5VBahfXOC96pu4f40gOngPW989Hx8U3NLfQluxLjXAZqqd9hNLKDrN2bnVL7z1sLiq8PGaz7lQI5lPHnygFAV6szJDVjyRTpzvx2VgpPpDU6o1koxteFugK9WaEIpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645867; c=relaxed/simple;
	bh=99vPfvbBA0u5UgLY1C9wKU4r3L8zPMWjeCFX40SJjyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZI3Tngo0K2vaFuJABmgxaZysLzbFyPb9MQFL0vEeVcQTCFfRKYlmXXzI+E1Ss1menqgEEpqucHDXTKG9M5tvWfvnxj8BaVgsa/rsm1Xa/VELn9kDXbhEcB75kNRFEeFD5e5hqMhudo4/F9fyWzANBe638En3voESOsETTI1jTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 2020AA0111;
	Tue, 21 Jul 2026 14:47:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id E8A2880017;
	Tue, 21 Jul 2026 14:47:47 +0000 (UTC)
Date: Tue, 21 Jul 2026 10:48:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, "Ahmed S. Darwish"
 <darwi@linutronix.de>, Jonathan Corbet <corbet@lwn.net>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, Matthew Wilcox
 <willy@infradead.org>, Derek Barbosa <debarbos@redhat.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <20260721104806.64afcd8f@gandalf.local.home>
In-Reply-To: <20260721143606.NqT15H0p@linutronix.de>
References: <20260716195716.256025-1-darwi@linutronix.de>
	<20260716195716.256025-2-darwi@linutronix.de>
	<20260721130248.ndwsFtHE@linutronix.de>
	<874ihs5s4d.fsf@jogness.linutronix.de>
	<20260721143606.NqT15H0p@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E8A2880017
X-Stat-Signature: c6yxtwqcrdefdykwts6nhp6xbetfsp8x
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/EEGBS3SQVbWmaqdQGs0MVCyUuR8AlJ1k=
X-HE-Tag: 1784645267-927536
X-HE-Meta: U2FsdGVkX19IcZncXP88k7vCZGmXRZYXYHAtcO/9hSm/UEUQxbCrUFw0AMNkAFPO3uZo8BuqxxuQSFFWZ3jC6GvHDMC2ZEDsbZj27a+vTT+3eLlcsaHKm+YQPmqPYMz9thbHkRNyXvVk5+v17W5q4BBtf4NBDmC0XNqjqDqJj22mJwZA6HmOSukT84ekodiypZZ1pBpeonx/4/QboOci/rmt8sicnjgIRWqEZ1qAVoGk/d03kiI6256ycA2rcwZdODYbEMi4bZo6TeNNR5CqfBq3A+VjR9RssVjgjsdlpLrMAcOhU8fEFWs7KkBmcLqU

On Tue, 21 Jul 2026 16:36:06 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > Unfortunately, debugfs is needed to configure the fair deadline server:
> > 
> >     /sys/kernel/debug/sched/fair_server/cpu*/runtime  
> 
> So drop the reference to it. It is not "bad" to have it enabled. It is

I believe that some distros feel that it is bad to enable because there's
no real auditing of its interface. Although, it is now only accessible by
root.

> just an interface to other things. Same as sysfs except that debugfs has
> no stable ABI unlike sysfs.

I found out the hard way that it can most definitely be a stable ABI :-p

-- Steve
