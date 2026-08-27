Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8645349C
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 12:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787834992; cv=none; b=PuMHSZBIkUd7WFtURS+cVO0J8sCEoAFOmePAD51tF7iK8sR++sZpCSFpbYCpfkK7rfafGDQkK2hl7VagI89PYQEQ2JDpOSF5nvl5uDPIq560Afi0MWh1UCtCX0oNDszSPcAwmN2Q2OQExORTDM8U0idrSui5jf4YDsYgWHrUtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787834992; c=relaxed/simple;
	bh=3oXrcChOhQDIZwOWpV8tcFU/qch8ZaBwDD1DO+AQYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDhzVW80bvenZmtKsG+OsdztAW+V6T2PE/PRgGggbkvwjB6KRIqWlAo5tIQkfwMuU39PTWsh9JFDMqjZrnEYdG9YwX/mQh5C24E/vCkYdUfcV4OHg+0dKfBkBrbrimgfS0aRmUYCRxsFaXGfXrGzrcgo6/CHsGLVVLhyw1spBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gEi596wQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMfmnweO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEi596wQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMfmnweO"
Date: Thu, 27 Aug 2026 14:49:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787834973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4ZaNwIZuCYL9LjEf8eghMjYQgVWPixb3pgdYvUamCE=;
	b=gEi596wQKkfmM/4JLwZta+cGNhxRYntB8tlekzAR71E5nNYbdWMpfC4TmBYA0Fz1ILQCNk
	kdq5bTOe8GokWi+2/NQ77ePKnGXoShua8tVWBpPz7rOuzPlKssozV9EmXzOnSBjgvy4ccB
	NDJpezO3itOVBmbQ02U1i1rGWSCPS79fNtjtfSxfS4FpwO8oBotsane53Cb+Gqss3Nh/qy
	JIl4jhmXUUEQm0a1oorGWyJPdgJlmmFivNRHHCCEci1NWxAXC8ID+XMJJeCw1lRgeSMaf4
	TYdc2soDRlDTVd/6rg2oO3eWNmQWJt/1DFK5Co8sRaVs4+9O/7XlUw0IlcXjfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787834973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z4ZaNwIZuCYL9LjEf8eghMjYQgVWPixb3pgdYvUamCE=;
	b=RMfmnweO0IpS1wz2Bya3EsDnIjAZZ4HMExwu/82UwkjhLlCkblOfQ847KCLhWN1j+KoGma
	Bx/F6R6OYCHO05Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7.2-rc6] drm/amd/display: fix usage of
 DC_FPU_{BEGIN,END} with PREEMPT_RT
Message-ID: <20260827124931.ocQEF6MW@linutronix.de>
References: <202608061233.eufnR5Qm-lkp@intel.com>
 <20260807124944.154232-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807124944.154232-1-spasswolf@web.de>

On 2026-08-07 14:49:42 [+0200], Bert Karwatzki wrote:
> On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
> converted to rt_mutex. dc_create_plane_state() can be called while
> inside an FPU-guarded region, resuling in "scheduling while atomic"
> errors on PREEMPT_RT kernels.
>  Fix this by calling kvzalloc_obj() with DC_RUN_WITH_PREEMPTION_ENABLED().
> Also fix the error path in dc_create_stream_for_sink().
> 
> Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
> Link: https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>

Thank you Bert. Got this somewhere in the meantime?

Could the FPU regions with disabled preemption be limited to where we
have actually have FPU usage in way that you don't have to worry when it
is needed to use DC_RUN_WITH_PREEMPTION_ENABLED() and when not? Also the
dc_fpu_begin()/ end() can nest and if they do the usage of
DC_RUN_WITH_PREEMPTION_ENABLED() is futile, isn't it?

The first usage kernel_fpu_begin() saves the FPU state to the user task.
kernel_fpu_end() does not restore it. Therefore the subsequent
invocation of kernel_fpu_begin() is cheaper.

Sebastian
