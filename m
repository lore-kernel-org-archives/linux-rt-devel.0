Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661140;
	b=yPIzkogESY5Bpa5I7kjROmqOR1BCK9jNm2CYpYZ9UxHQfq/uT6MzNYcnXebjhCZTRDg2
	 U0m6o5q9amV3sTcMIVPSzjj2kDrzq+M1kfuqO7gSM8zpRKsrU0EI26XrRumJ4b6kX6BaV
	 +paBvl9K2v0XPtc8dgfBCL0V5xBMVgS1D8LnlUch1A0n9YR5p6vOd6s/Ts4W69XzqMbOQ
	 huBSos2u8XTBegxi8b4xy4izFiFpJDO+EScHrdzO8saBnLUTXOn5IwRkyRQLRiixV2sBf
	 rTMwehsWkdIEQw9lHutZ9HghVMkJiZTOZRYZq9SLdv5rplck1cAZ4B+eEnq+WGoAZvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661140;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=VxGf/bIpRdtWm16AMZt+HAAkeirvJAbEMkUq6q7JIDQ=;
	b=oVh6pKvCC/3seBZ2C5jTj8UBV2tq53kVKZ6g4u839/oNnjRPUcVC177E8TVgKZxUPK0R
	 xUAFTNnC658J+qTRtdtDZvD8DceTznprdCAfV9oE0eqrGIiPlddGqheg4XHRqYcbE4BqT
	 rLeLJxFimAybUVoBJXwDCviUXjS5s+UDSx9ufuRTrYdrDpZ1AGSBZHnbRJSolFgUbNe+q
	 L9tkHsCbQmJuCq9tNDGC03160i1Obt5/YXMvZF+c3kp/4h3FYBQE+V9InaiwJsf6xeQhq
	 721ESgTdMSFzqCbdV/Pcrwo5pYF4Yat9pR8O/EU03gOyiFnn8uyc/4EnCXzgoPXGUGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="AG/vJsYn";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=4QVwWeYj;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DB2606A31A
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 09:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34DB2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=AG/vJsYn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=4QVwWeYj
Date: Thu, 22 Oct 2026 11:25:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792661138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxGf/bIpRdtWm16AMZt+HAAkeirvJAbEMkUq6q7JIDQ=;
	b=AG/vJsYn4QJuWWnOp6tvE9xcmHmv/h0kzkFDzH2OSvy833vOjAFnmz/WZwEYo//hGryNo8
	rfzRjRCIUEoHSgRzuuKz0prFFdH0VNppYZaRSy1VTb8xbX2PXZZeZ9aduaV+TetVD6Pvm8
	jmaUDor5ncBfSVExOMu58WPloIM7FPaoU148Mn8clQvQTsB1QGmcNoWjTPVrLTERY1ejHq
	rTQZtJeim0beUVXcP23q0nS+eW4LZ/Iqm2KC/z/nor5hvmEWIGHRqlv2GzU3RFMV7mTdKL
	90KuSNwQrqkaOd//HcBsrvZlhvqwWRywtGcYH5eD0U1IJLw7S7wmRHkKrW2Haw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792661138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxGf/bIpRdtWm16AMZt+HAAkeirvJAbEMkUq6q7JIDQ=;
	b=4QVwWeYjmPgQRODez3TLiC0wbKmtc0LPZofrCLs4w/Yg4BJcfFbTxhuFCvZZISdw6jsUPA
	9y9eX5Ach1VnO1AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v6.1-rt 00/15] net: Backport backlog-NAPI threads to
 resolve PREEMPT_RT softirq warning in SMP flush
Message-ID: <20261022092536.HVMUjSuS@linutronix.de>
References: <cover.1791912669.git.wen.yang@linux.dev>
 <20261014150853.f8I2fNx0@linutronix.de>
 <atDWZDywit4ilzJ8@demetrius>
 <20261015133811.PtBdJYyx@linutronix.de>
 <2c3a8c0f-3820-4531-b179-b2656a7d3c7e@linux.dev>
 <atJ0axhl3AHQIDsa@demetrius>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atJ0axhl3AHQIDsa@demetrius>

On 2026-10-16 14:00:59 [-0500], Clark Williams wrote:
> Perfect. I expect you'll have a small series for v6.6-rt and then a
> pretty large one for v6.1-rt.
> 
> Thanks Wen, I'll be ready to apply/test when you send it. 

"[PATCH 03/15] net: napi_schedule_rps() cleanup" has

| commit 8fcb76b934daff12cde76adeab3d502eeb0734b1 upstream.

in the middle of the commit message.

"[PATCH 14/15] net: Allow to use SMP threads for backlog NAPI." has only
context related changes.

I don't see any SMP-function calls with the series applied. This looks
complete to me.

> Clark

Sebastian
