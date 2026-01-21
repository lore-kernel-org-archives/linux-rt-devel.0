Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA38342C98
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001590; cv=none; b=L0tEHIqc9JmVpBGp7v9pSguY9Mh8zx6DfZ2p+fGkQIfU+x4gdOi+665Z+JuMStEbhO72mOKuZI2oP66M/ql/gqaJplfqG3N56jr90RfmDPXTOXQ66kRLrA/NELLgyrtMtDZRjNKEQs0Zn2rhD6gkZvEw/VOX39/7+BNQhp7onhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001590; c=relaxed/simple;
	bh=gS2+iHxIbevA83J45Omvh8/BUHWmgVWea1xnhRoZIig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T87V5wTqzmjVNuuOq5c9YNHlinWgHqhT6uRhy6553u9SlMx0ggfzdlxEJCDNkaiunU15SMVSGIMuh5MR+++QMSjHJiviY3PMPFJiSlBOWZ1H9t5sAmlyPT511rGbRRMdbwOXfZecXRSqc7KnAtS5cYR4PXur447sr5/22z6XpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QKy0MKmm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Emw2iIPf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QKy0MKmm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Emw2iIPf"
Date: Wed, 21 Jan 2026 14:19:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769001587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gS2+iHxIbevA83J45Omvh8/BUHWmgVWea1xnhRoZIig=;
	b=QKy0MKmmtsDWsex5jjbDiYzULhWZhMSKLDtYJaJVkWh2KoLFS6G0SMQAUW581hm/A01gC5
	MaQDYQFKxSNw3paCHGHBznYCmTAOc6kyOE2elI2woIrzgYZx3wLDd0oHzwggwEVzIkFEYN
	rsDJNv2viTyKzZgFnH10vWDFNu8rszKm6BH+yRc8L1Wa33EwGPl+GBYJ0D8o3y0g9YYFMx
	IvmjH8earqkeg5Sfa2dmRf8NQEpBaQTWLtVNDtSD+ac18R8oV7rysax7iHVLSq8bCwRdEd
	A0z9wziULb6Lldfwo8qVNCS251e3+39n2IZ/Bpu15ZyzvhZlg74/3jbVWB/W8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769001587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gS2+iHxIbevA83J45Omvh8/BUHWmgVWea1xnhRoZIig=;
	b=Emw2iIPfU/LjQBQfEsFgPEyEfYs6Rw1TSZd9/MgsQG/gXXpbWh1gUu7ysxdHnWntVYSc3J
	fseZOvj/X0D7OUDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: hansg@kernel.org, "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	sfr@canb.auug.org.au, ilpo.jarvinen@linux.intel.com,
	regressions@leemhuis.info
Subject: Re: REGRESSION on linux-next (next-20260115)
Message-ID: <20260121131945.i78zWqhv@linutronix.de>
References: <555f1c56-0f74-41bf-8bd2-6217e0aab0c6@intel.com>
 <20260121075348.5MyqcHFB@linutronix.de>
 <89de03a5-e5da-4d2e-8547-8e54ad73b324@intel.com>
 <20260121090154.Lpaj9hrr@linutronix.de>
 <5d83c0d0-8f82-40a8-bca6-7052658a5fb6@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d83c0d0-8f82-40a8-bca6-7052658a5fb6@intel.com>

On 2026-01-21 17:43:50 [+0530], Borah, Chaitanya Kumar wrote:
> This helps. Thank you for the patch. Would you be floating it soon?

Yes, I will. I consider this as a tested-by.

Sebastian
