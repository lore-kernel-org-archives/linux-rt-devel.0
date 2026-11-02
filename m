Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616494;
	b=gxXrD2/XVYqO0MunOzFXuKAJLR38xq2IagkPlBIRluM/dMSCC/lWacmQf/jXuWaz0Fds
	 To2df3f75nCtgjyZknvna/n38uyb3YRvtz1YyxyanFk6+M9AxIh94yjWmvLf6VnAuVJfJ
	 DRBsgpcxyFjU7sA1aIVvX9UDiNgY48Tnf/dfluzm1PRsqW6Xyx0DYUPT5RQr36MqeeL2K
	 iA7N7OHHKtg87amQe6ueulM7zvuYeFlFyHfqD2ckU0TllhiZ8SxGxNSslH7r01UoB+QRF
	 0cPPUyrwrgZ6+hFXhM2NA/Vl/dU4FCAksZGs5S6rwzBcJ55upPJ6U8z/oiluVG6tf1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616494;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=7TybYJapurBJ53Vk2S75p+aCvSR5jRQRLRvLf3wTrrs=;
	b=wu5WAdQ2BM6dDuo81FT6Ba3bFij9QdI5bgHyNwKhnl76sQ47ilHcyKlUSE8MmNowUcT5
	 NMWKJywK4GsOwalOdbjqsyNwrl6j2y/ZeOnrb4ozJF2wLThEDsH989w1Ymsvsg5RUH/LQ
	 RLanY2VDlrlENp47ELXIiUIUidIqomB/cHVYUNafd6Gtp4YLD3I+OC1E4omVt3qP9yQQo
	 KmQaowITSnll8OEqXekPA1KGkLGe4c41S5eu9benLrvTvFXyZF75Upb1MQQoVium/tGI3
	 nHPOvEXdGPpRPY5kdQFySuEigo2plYhEbFyDxdlF4wwNlc1o5YCtzRO0JJMxdACcBTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=iWpTOJuH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5dnl+SmA;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C91606A32E
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Nov 2026 10:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42C91606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=iWpTOJuH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5dnl+SmA
Date: Mon, 2 Nov 2026 11:48:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793616485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TybYJapurBJ53Vk2S75p+aCvSR5jRQRLRvLf3wTrrs=;
	b=iWpTOJuH3vNRgg91GSHTWWGQ+hbOcaFsWiBB8EHRcezLQPU1uPwpdu8oJlf1JpEyK15e4w
	Io3VxJnPz0j0VgY2CG90dp/XcQkgdWaPtZuXsD/kG9rkUsTIvTG098AkR16kBI6SGsKfqk
	vwmTPs/4qC1dYBP7uj9d0iz88mEkBbx3pIA4mT7XjicqB31c8LBFvF4iO2ehKDcgjnCM+k
	ZCFJQBUOEQl4I8FyAzgLt6vIM00r//p0RYz3dh/vRlfMlunx/hBqUAiAGmJxbWMKKG9Cvm
	yoD10sY9oRjnhzIFsM2g8QFXpXbpc/45RpVSbHQoh8DLR8Y9tofwlzve2hoM4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793616485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TybYJapurBJ53Vk2S75p+aCvSR5jRQRLRvLf3wTrrs=;
	b=5dnl+SmAnizcvZX2GliMqQ9IxIv/7c80EC4G2HGEIc9lOJTR/RMtJGilhQrfnHn0GTy52X
	Gxe2uBRhsMDwxNCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: wen.yang@linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 6.1-rt v2 00/15] net: Backport backlog-NAPI threads to
 resolve PREEMPT_RT softirq warning in SMP flush
Message-ID: <20261102104803.Dmg_a5dz@linutronix.de>
References: <cover.1792847031.git.wen.yang@linux.dev>
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
In-Reply-To: <cover.1792847031.git.wen.yang@linux.dev>

On 2026-10-24 21:30:24 [+0800], wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
> 
> Backport the backlog-NAPI smpboot-thread mechanism and its prerequisite
> NAPI/RPS/defer_list work from upstream (v6.4 - v6.9) to v6.1-rt-next.

This looks okay. The changes already landed in v6.6-RT so this could
land in v6.1-RT.

Sebastian
