Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE9EEA8
	for <linux-rt-devel@lists.linux.dev>; Wed, 17 Jun 2026 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781700556; cv=none; b=HnyTH3BPinzeXm98GGn5V2eP3XUfSGDUVXNeqQTL+B7v7oNiir/1rAiZNPhk4f2BXPdC7+MireOaMzxEBAGom81rbUDWbO5uTfg12AeKqnvrD7KcxsXEnU9cT3YbS0g4qxaQ+haAziAt2Edb3KsGaISeAnqUIYWasHCXQ5QCcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781700556; c=relaxed/simple;
	bh=fDAMEHEJ9xrFqSiWPkHU8F7DrP2LgGpLQ1ELm2/EC70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLcLZv+Cr7Nxb3kxkBjfBZGehBNGpSaAdP7HdzZpxRDVkyp1XaDu+yxXMqfaZ4wxqOpzE+jVdbeErWHQQrrS675GDx6SZu3yJrNHSFwBpnNKGmqsL15mgoIxGtf4O0YMPMkdpNY6TOkwQ2EMM2ulsUtLeDegHSav0ukqADzGdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DMiiXSW9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DMiiXSW9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 461121A3970;
	Wed, 17 Jun 2026 12:49:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 17DBB601AA;
	Wed, 17 Jun 2026 12:49:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67F12106C80FB;
	Wed, 17 Jun 2026 14:49:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781700551; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7U1EsqHD3joJo6K5RI3ZEt2ypT632SvDp/Xsssj+cJE=;
	b=DMiiXSW9s2vDf6Ix6fXMzCn1HqRGHNhwYwFtv0jOuvSZzYYZFOEoU/uvCMne62NW68yVTu
	AqIxz+Fr2S+CvoJrCmv33dwNE5T++PjJIi4zHwdfgj03mUs4bEclffQGL0mfMQpNWJiRMC
	F78GwoXF+7rp4AosqXxsffNDgojg5f4FlGYA6j5pe+OEpDL+Rf2izku+hlj3yFcgpwCUja
	1tSk53MA8ljPzzxtIsZFHaxzBuozYy9TZRiM8iPjGdzQds3fkkeevx7wiWr75zpNU2yxBP
	TXWRcYI3iwGbnC+PuStsuoOfYjFyBXBNBczgkCjPx3qWjjTuti/ogE2BTaBGdw==
Message-ID: <95249596-5f05-421c-9c8a-693c7b26c4f6@bootlin.com>
Date: Wed, 17 Jun 2026 14:49:03 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mvneta: free/request IRQ across suspend/resume
To: Yun Zhou <yun.zhou@windriver.com>, marcin.s.wojtas@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260617092028.1722407-1-yun.zhou@windriver.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260617092028.1722407-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 6/17/26 11:20, Yun Zhou wrote:
> On PREEMPT_RT, the mvneta IRQ handler is force-threaded. Under high
> network traffic, the IRQ can enter suspend with desc->depth == 1
> (masked by the oneshot mechanism between handler invocations).
> 
> During suspend, the kernel increments depth to 2 and masks the
> interrupt at the MPIC level (clearing the SRC_CTL CPU routing bit,
> due to IRQCHIP_MASK_ON_SUSPEND). On resume, depth is decremented
> back to 1, but since it does not reach 0, the unmask is never
> called. The MPIC CPU routing remains cleared, permanently disabling
> interrupt delivery.
> 
> Fix by freeing the IRQ in suspend and re-requesting it in resume.
> This ensures a clean IRQ state (depth=0, proper hardware routing)
> on every resume cycle, regardless of the pre-suspend depth. This
> follows the approach used by other drivers (e.g. igb).

This description makes it sound like it's not really a mvneta problem,
but rather a broader effect from  preempt-rt / irq management / suspend
interactions.

Is this the expected way to deal with that ?

Maxime

