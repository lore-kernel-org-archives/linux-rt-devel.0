Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6E344D9D
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Mar 2026 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992569; cv=none; b=gsKzCaQjQUf0KIWvW/4Ov/7Oe2GPyjhuU3qFADomsRavIpl6xumpsAX4lc1k9HycEaLLfCxwPLxA1gUbTm9YbaUJbDISUfM0rNVdlCA9saaSYY/DjEuEIr/AVWnfHpP1kb9Tn2SIcHHowkkXO6KdYTcFtoHZGjNBiqSV7GuVCKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992569; c=relaxed/simple;
	bh=0dCgqHkboWZHR92xSaIEcbRDFKUPTTR6UrXrj/yEGWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA2y46klFiYu1YLpNvNCsVaZwXEYAGJJJ/+HZnWUAA71dUM12ws0U+ZMXYzeCd7Fr9B36fc9ONRZcvTwM3j4HoARPknNNXRcI8k41I5h1sTN8oUAefqy3aj5xwRN3HKk7Cykwe3Dm44ZyxVeNPSNtgCcYmjsqo/OyHTFRDTBp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YIOJN0Gf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ElOMsQcl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YIOJN0Gf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ElOMsQcl"
Date: Fri, 20 Mar 2026 08:42:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773992566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MshMtRZGT4p94HZtMOMgVziJMH9fBPmkrzXedqSzHHE=;
	b=YIOJN0GfnmtovTSZTpcfroGQxeM66sH4Yrhdl5VvWOh9FQo4A7czDOMHHQohWcSBK7m3EP
	R8gV8i4mcq+sWBedgy9kV8liceIdoB91dmT2/axGJr90Jrq4HM/fvEcVlk2sAPCtOwmqXu
	dxeAeOQBbBtmmcNl5ATN1MP63yRgc/XdoTFIYJCRF76pdAY3g9+N0pU9HdHVOBrYTwAOoC
	R0EyuU/ONlLVqNLZCWSmugffS0I7rECLSfyn3mbeo9XotGS7gZA3z1RtmO2Gc+Bv5VEpE7
	nYUZxplpa5Y0odolF7hNasjFNxtNc/UOwkyHqgduL1txuGG6UgKe/dLAm7m60A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773992566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MshMtRZGT4p94HZtMOMgVziJMH9fBPmkrzXedqSzHHE=;
	b=ElOMsQclM26S3Ox7+9FT1+gr1Xuy1uzdrOR2tkwl7bvcxy7j3TCN9R1jfYyQER4pH5rhWS
	4gecTzup0E+/A9CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev, sgzhang@google.com,
	boolli@google.com, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 2/3] idpf: improve locking around
 idpf_vc_xn_push_free()
Message-ID: <20260320074245.f8dPuv4j@linutronix.de>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
 <20260319211335.23236-3-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319211335.23236-3-emil.s.tantilov@intel.com>

On 2026-03-19 14:13:34 [-0700], Emil Tantilov wrote:
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 582e0c8e9dc0..fbd5a15b015c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -402,7 +402,9 @@ static void idpf_vc_xn_push_free(struct idpf_vc_xn_manager *vcxn_mngr,
>  				 struct idpf_vc_xn *xn)
>  {
>  	idpf_vc_xn_release_bufs(xn);
> +	spin_lock_bh(&vcxn_mngr->xn_bm_lock);
>  	set_bit(xn->idx, vcxn_mngr->free_xn_bm);

If all of your bit manipulations happen under the same lock you could
replace atomic set_bit()/ clear_bit() with their non-atomic counter
parts __set_bit()/ __clear_bit().

The lockless alternative would be find_first_bit() +
test_and_set_bit() loop. Probably another atomic op for salt. Using the
__ is free with this change.

> +	spin_unlock_bh(&vcxn_mngr->xn_bm_lock);
>  }

Sebastian
