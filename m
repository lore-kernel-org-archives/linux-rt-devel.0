Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC48330F959
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168959; cv=none; b=p4O+mw/4wVgBYIU1m+wOj8THY0mCNAvQ70GWQeIos6ZfE1vTb2hqDtBy1pZtONuq4qJtZsnafmwtyOos7swzcDrGEjaNgT6Tylsz9WURwDyx4M9vS50dUAtvyqLf1TsNb9qU+CXSXVJ0+0iL13FAr1D4eZ5ZHKDVj4fm/epFu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168959; c=relaxed/simple;
	bh=P7ESF9382DYW9xGM0dKsbx9SyxLtgaLH2JKVh+jBx+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz96hoYc2iHG/dmrB2jam0jArWcMfBrcsSrzyH5bjK2y4UCcjzvBsCToVhniuqM36J8SFDSSOEc3zxAQ3nlmKpqoCGYvzwtCIEc3zx5aeQM58AmjfFHcpDM7eNpZMJqowjw9gk7xvzJ9beJmlQGlzMQrr1fn8umlJVMI37U41qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vuc/2WmT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=elfRF44K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vuc/2WmT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="elfRF44K"
Date: Fri, 23 Jan 2026 12:49:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4eg0iatkrMjFveyALq9tmaSp5L5sCUQ5SHyOv9SM5M=;
	b=vuc/2WmThHuxTuvMPDYZ+sMmvOP/2P5Cvqhfcmptsh0EpjN9Vxol24vXcKtbaqeRn3O0vJ
	an61Dl8hC8xYtUYZQrTQ0TrxaHiXlKTSLB9ozbsuTTkD/76sUjxgJIlYLZ700ATKnlE1up
	/g9WaOFIYpiVlswqeSP960xfQsYwEqI1g+lV0R0Qgb8GLfRw/gRmF3R1a+LoqrQCo3FNl/
	fiE42uBwRTizq8Pc/6EXWQz6j0XZqcwp4j6Y2rjVIB8dwGStIOgOfyMA/A24NP5eie1GH6
	iszujzCsHfCKOU1GBrteymJyUKDzEC/6XSrZXXwYclFrAMB2NvebhqFh+xbFWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4eg0iatkrMjFveyALq9tmaSp5L5sCUQ5SHyOv9SM5M=;
	b=elfRF44Kk/ooBqJEqO3vdG/+mojig3d0T1CIPNNc+8vYpTyzSjuijvhKi1ktwxBAEQFjpM
	/ydqC/YXg1MXArBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Subject: Re: [PATCH 02/21] platform/x86: int0002: Remove IRQF_ONESHOT from
 request_irq()
Message-ID: <20260123114909.BPVv_oBm@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123113708.416727-3-bigeasy@linutronix.de>

On 2026-01-23 12:36:48 [+0100], To linux-kernel@vger.kernel.org wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> The flag was added to match the flag on the shared handler which uses a
> threaded handler and therefore IRQF_ONESHOT. This is no longer needed
> because devm_request_irq() now passes IRQF_COND_ONESHOT for this case.
> 
> Revert adding IRQF_ONESHOT to irqflags.

This one should probably go hand in hand with the previous one. It might
be easier to route both via tip/irq.

Sebastian
