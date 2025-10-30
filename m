Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CE24337B
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837551; cv=none; b=hQykjacpzbP1/YPgbEapoKmRUHRSVxEjbnl4/q9VtHKvll2eiWmTIr4rFanKXgm6/kd3ou8ujNLzaBBNPfqbxWkTnjpFGN/oS9r1JbqMSq2F0cUnTtkQK8PcHekN0JejestrnAtv1QDcpbdjdXzdm6Ue2OiIQxkCyEMkg97eRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837551; c=relaxed/simple;
	bh=j3yLm1kVPbRgBf13UOubQUduLyyj0okiDzcPZgN6QS4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OoNJ2eWMsQLa1INMD2qROX72nPLU7p9S1zGhTWWeeSu+q/EIfIMWV3fr9mVHQfQKRSCmT5+0sOD/Lfqpvqhwa0P1AdFiWf3IxBvF5P8G8w7/BmKW8MKnYhDaQ9XKkJUAEG1ly7NOELONBJ2jBEwJXo8CCn0XFwFckxoYJputJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UXIt0JVx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uq+PX7pd; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UXIt0JVx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uq+PX7pd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E2B51D001BD;
	Thu, 30 Oct 2025 11:19:09 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 11:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761837548;
	 x=1761923948; bh=P0SwesoPyJz+syejXsAX+S7iKTALPDfUQvtyQOyFo8o=; b=
	UXIt0JVxp1q/NmIgoBkQxoJx/fQwdQ/u9GxnOEMykZ8wb39OufR25I9HAw96seAw
	Aebzx6o928bShL82jkGjDLWqZM+l4TEpnjgdZv9a+UosQ2muBbKs7MLWmJXvOkp7
	oseu1C/Js8KWmYIjbXf840oouUZv2MqRfmaIzxIW0XAE2in1+XL9xdhIMKPl5yLM
	g5e1VpKwrN57Wn9+us+I55H4ss2BK+LS0zOURg+qPlf328gXPG7UMhnDnOqR0Fv5
	k1g+pkezrkwEtUntvxdoLOoFRca9Uf61lvMzVFMz1M/3GbgXYfVvCRK0lTc4vfYW
	zeQktQ/OvtR4UYnoaU7TTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761837548; x=
	1761923948; bh=P0SwesoPyJz+syejXsAX+S7iKTALPDfUQvtyQOyFo8o=; b=U
	q+PX7pdnDvZvMn+IZ0AqEKiqWQXV/F/hb6HM6kDBDJ+OqozqrGt8PDRBdieoyYP2
	4LbWI9lvXfsvXhTjQTbzum4YC5G4TaQeO/ZGcxZ2JnCtxSRPjamE7k09RkTwSwbx
	anVCPhrotzErZOyig+M6CKQY1Pjy6I1aXJUb5o5V1xpCsBuzZw8w/tswTB//RY2G
	gDFlZ4+67QVu4RD2gpaFJ1eMK+7AL4QcuSn4oF3kLh3y0uWtsPrhkNyto1a+eQrn
	gLCxdrxoG2Ql/ofcDvfdGLDcmyvu65sseA6bO2dHPOVp0g4BspLaTrgAAR9NuBmn
	rdqKC2Ij7s4G5wkRS0f1g==
X-ME-Sender: <xms:7IEDaXHsA1EcLr4gyf8iSY_35WnREFH1gKqwcuTDndTzhp4v-l-IdQ>
    <xme:7IEDafIF1Na2MSZm1K5n7gsIR80Hp1UrLET4ElrHpOsaOo5xdMvSSyK53n4rb5t2Z
    D-HY_vM29x59sh5zYy5Zp_8BsjswWEZOrlks3zswXPGzoQ7ZWtvBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeileegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopeigihgvhihurghnsghinhdusehhuhgrfigvihdrtghomhdprhgtphhtthhopegsihhg
    vggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    lhhinhhugidqrhhtqdguvghvvghlsehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:7IEDaYa074gn6BzWsNOfY6SYTRF0LmPp5qZHy964iNzeIHlxzVuDtg>
    <xmx:7IEDaXGCOUHMqKOj03GBev_O1npopLVyY7w805543PwdOSHKxqBLjQ>
    <xmx:7IEDacxqnfeQSQQb06SNg21UXp9rF-bEyQbjpS_5-ukcUgP91k8-_A>
    <xmx:7IEDaZkw9xt6hqkznrTm4py_VMJi0EwZpGsr7OXx8GW7OTWJvoTEJw>
    <xmx:7IEDaa-6G2MmxE_HaNU9_OYjjn7eA5LJS909Zt1pLMmtgECRZGpKROhc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4844C700063; Thu, 30 Oct 2025 11:19:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: ABs-jBIYyMx3
Date: Thu, 30 Oct 2025 16:18:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Xie Yuanbin" <xieyuanbin1@huawei.com>
Message-Id: <1ab2724c-4280-4193-832b-4afc0ba496c1@app.fastmail.com>
In-Reply-To: <20251029155918.503060-6-bigeasy@linutronix.de>
References: <20251029155918.503060-1-bigeasy@linutronix.de>
 <20251029155918.503060-6-bigeasy@linutronix.de>
Subject: Re: [PATCH 5/5] ARM: Allow to enable RT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 29, 2025, at 16:59, Sebastian Andrzej Siewior wrote:
> All known issues have been adressed.
> Allow to select RT.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 99c9b1c320af8..002db8da69ee5 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -41,6 +41,7 @@ config ARM
>  	select ARCH_SUPPORTS_CFI
>  	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
>  	select ARCH_SUPPORTS_PER_VMA_LOCK
> +	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select ARCH_USE_MEMTEST
> @@ -129,6 +130,7 @@ config ARM
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> +	select HAVE_POSIX_CPU_TIMERS_TASK_WORK if !KVM
>  	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RSEQ

This can be simplified slightly since CONFIG_KVM is long gone on
ARM, so you can just select both HAVE_POSIX_CPU_TIMERS_TASK_WORK
and ARCH_SUPPORTS_RT unconditionally.

      Arnd
