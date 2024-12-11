Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7AA246339
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927448; cv=none; b=dSSRx44vo6F41hQLPcrvNOe+PJRgxVRrsrE1YsWMT2IQtIhLpeoD1Pf+U33oJ+fs6hh4j2UvotL/Tx/Pm4tDLUe2aP/Ep8cKGjS2Sal36dJLdUsh8WVSz4S1kaKFho0dIarP3VlOO0SImcUmWQw0M6Ro70wACIxm51J2467QN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927448; c=relaxed/simple;
	bh=nk9913aeWjtq5YBt0cVltxl3l1Q9VRPinFITp1bT/Rs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XaOV7CY/4fMCx1pWI6UDxjmVew4jqj0QueDpgFXSG1eIWbBXVkGjxg8Ezj1JiuyQqhOVnmX8lJqGtZbbB6qI4ynSL4CXK6xWu53xCFfcObtRdzY5Yp9zXNFWcEL3/l5UTtb0sXfEDHet+ZnmI5b60TfC6EPbFnsd7LYLofG3icY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=d2UhremK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbNGuJt/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="d2UhremK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbNGuJt/"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2578311400FC;
	Wed, 11 Dec 2024 09:30:45 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 11 Dec 2024 09:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733927445;
	 x=1734013845; bh=JTP3OPECQyV1SzxOkgeH7HPscSun1SYrJfiExm+YsY0=; b=
	d2UhremKMqQVpwt6dyUivFCbkKlUlacN/Jj8tBNZUZpfjb30SHVTyDAO+mByeNW4
	L+jaR/IMTbVTWsnB3yIQqu5Su75C8ukqiB8sXIQw6E/fhy3i6yO1zcDcKGu1Oo+I
	XCcYtjt3lTSTHj/Ti3zfkHoV+za2l7oOaOd3JZx8yuhIIs58Gh9UTWOBtXH4z/rL
	6Ndx8oPwj2HTXN78FQYbF8vvFcFs0WQW//djqA8s523Jm2CJvNhibKHBUd14ddGq
	+v/P7NUerMYuF1ZhjV4TYxLhPgYTu3QFChsidL15hsO64AKnH9TRMJx3AqyHHsss
	9v3x1QwW2zrkWkmb+rzkUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733927445; x=
	1734013845; bh=JTP3OPECQyV1SzxOkgeH7HPscSun1SYrJfiExm+YsY0=; b=I
	bNGuJt/s/P57Ze0tDP3fn+4FGvy6B5p80I01viN8974e6ojcYGJCF2VSnijDXbSl
	Ds4uRJ5aguHht9qZwsffxSblj7r76loA+HT/5JRO0lyDpoSdFn+mbQYbUZH/vUVP
	2XWjfkgrvEXQLXRYl4DGRrz/rWtByARlgXz4Akiqb/3soT7OoFeuYE6/WDyw4e+m
	JBxaIjdEGgk0LrG2G5mA377wRFoKQye3Eo2ZrfLxnbcBgkCdamIfwTV8UHkhVaF6
	MNCMj46+HOAPGTR2qaRpWeH7tGWrnvJtevDcJf1pi7I3Y1DjHkxZsfDO7L2Hsst6
	kYygU3dgk/SI0oTq8UAXw==
X-ME-Sender: <xms:E6JZZ_NQVjENYuzeFTohShHOJo8Got9K40_LwokaBkglNcmxGHwWZw>
    <xme:E6JZZ5_ldDCeofx5bz0NorjCgVK7MxBG7qxOZ68pDXk38HuD2n8ZDJkVmD4Zzscsi
    dhYly-hu2DCxbxeH3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtg
    homhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphht
    thhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprhhosh
    htvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhn
    ugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghlrhhkfihllhhmsheskhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:E6JZZ-T2BjCydPWt6oWqZLp-rQiQV0uMfUtI8DK90S3TYLJUbxpUQw>
    <xmx:E6JZZztj20v4pEJoF3ZkKz-ERhZAMh1eLbtvSjNKQdagyvZqsnjCWA>
    <xmx:E6JZZ3cGOEjSXWtKvcpTTvL2_3mFVUB0mY-kjvcOK3Ds_vlTaUnAzQ>
    <xmx:E6JZZ_1GRL69c-IehVNSHabYfG-X8-3MtOazQOmbm6otd98ppqcC_A>
    <xmx:FaJZZ_8Zgn6NGJZ0rSNeuiLDxSQ0Y5mvclfAi3bSug8TSC_du8v0bUeh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4EA812220075; Wed, 11 Dec 2024 09:30:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 15:30:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
 "Ard Biesheuvel" <ardb@kernel.org>, "Clark Williams" <clrkwllms@kernel.org>,
 "Jason Baron" <jbaron@akamai.com>, "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Mark Rutland" <mark.rutland@arm.com>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Steven Rostedt" <rostedt@goodmis.org>
Message-Id: <001c1d0e-a0fd-47f4-be35-0fd808f3b01a@app.fastmail.com>
In-Reply-To: <20241211140402.yf7gMExr@linutronix.de>
References: <20241210160556.2341497-1-arnd@kernel.org>
 <20241210160556.2341497-3-arnd@kernel.org>
 <20241211134811.wM_UADhQ@linutronix.de>
 <20241211140402.yf7gMExr@linutronix.de>
Subject: Re: [PATCH 2/4] ARM: Disable HIGHPTE on PREEMPT_RT kernels
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Dec 11, 2024, at 15:04, Sebastian Andrzej Siewior wrote:
> On 2024-12-11 14:48:11 [+0100], To Arnd Bergmann wrote:
>> I guess if you have boxes with 4GiB+ and can proof that the performance
>> improves without HIGHPTE (since you don't have to map the page table).
>> The question is then how much of low mem has to be used instead and when
>> does it start to hurt.
>
> Some numbers have been been documented in commit
>    14315592009c1 ("x86, mm: Allow highmem user page tables to be 
> disabled at boot time")
>
> and I would like cite:
> | We could probably handwave up an argument for a threshold at 16G of total
> | RAM.
>
> which means HIGHPTE would make sense with >= 16GiB of memory.

Very useful, thanks!

On x86, that means we can definitely remove HIGHPTE along with
CONFIG_HIGHMEM64G on x86.

On 32-bit ARM, we still need to support LPAE for systems that
require 64-bit addressing. LPAE supports 36 bits of addressing
(up to 64GB), but the largest actual size I've seen mentioned
is 16GB (Hisilicon HiP04, Calxeda Midway servers) and I'm
certain nobody actually requires these to perform well
given that they are no longer useful for the workloads they
were designed for.

There are also a small number of embedded systems with 8GB
(Ti Keystone2, NVidia Tegra3, Marvell Armada XP), but they
are rare enough that turning off HIGHPTE is completely safe.

      Arnd
