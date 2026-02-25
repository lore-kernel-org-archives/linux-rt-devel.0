Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6010439B4A1
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020785; cv=none; b=XWiw5vMK4yBsqziqJMQMw8LFMK6+h5yAcQqNR3dXdC1vrNgfPhypvPA3Eh+WRiFUdAO2ynQ6dLxs81XiaCEcmco6gDOp7qIc0G7kyEg3GEaOj/uKoezvMC+tuEJsbTYNfJtN23u3h63u/eJtcsD3OeOB8PmXsrumXzaKMtxyPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020785; c=relaxed/simple;
	bh=0Lz7uZRTXCWj/J+aEommdk6N7FhzZohw5kJNaec9mzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHShY9ZuVjr/oCJMpw41b6sOUdXgr//MzqvAc/FWd84/ioDDGed5ntvA88ibGEMfCLFtdTKSPEduSGQ74iCwARoWxX6vNRkwvyKnx+uF2OpRq3EcT+wgiAjHF4pNjBUKjv4RukQ+jOmiDb9/47u8z2OuUcjj48e3Q5Aad0Xn0YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=GSR4sYTM; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="GSR4sYTM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1772020774;
	bh=0Lz7uZRTXCWj/J+aEommdk6N7FhzZohw5kJNaec9mzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GSR4sYTMP6QN+rF38uAsipmaRY+lwOiR8UdQHXC3/xOo7jq1E18WBF2bv7R2lDMmI
	 KJHS2KrA8euWPpJibK6Ml5f8jZsEw7pwumyADpd27kUSbg06dBekw0scC/IsXGTcGi
	 lV6zUPQTkFqSH8Thd8mprYZQAPAzmvgXT8e+TLB81UKQQICK88Z8SLCBS6BNoiHAiT
	 GHZWRv0RrwpiIKuRIP0SDFRQ8F2M+O8uYrN/qOxdXrNhbpkUBvrSOMBGoKoSYo7WIO
	 62pw9EtRcrZMPPoZX5NRbwz2trWdrAZkhvk568xpRGyfsHaMyNGIw2iOXv8lzVBuId
	 EUvs5xknWyXuQ==
Message-ID: <35881d45-3a17-4f82-aae8-65579b10a9a6@lankhorst.se>
Date: Wed, 25 Feb 2026 12:59:32 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [i915-rt v6 13/24] drm/i915/display: Use intel_de_write_fw in
 intel_pipe_fastset
To: Jani Nikula <jani.nikula@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260220083657.28815-26-dev@lankhorst.se>
 <20260220083657.28815-39-dev@lankhorst.se>
 <4537cb8e981e2f49e1ba212237134dc5e812756e@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <4537cb8e981e2f49e1ba212237134dc5e812756e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

Den 2026-02-25 kl. 10:25, skrev Jani Nikula:
> On Fri, 20 Feb 2026, Maarten Lankhorst <dev@lankhorst.se> wrote:
>> intel_set_pipe_src_size(), hsw_set_linetime_wm(),
>> intel_cpu_transcoder_set_m1_n1() and intel_set_transcoder_timings_lrr()
>> are called from an atomic context on PREEMPT_RT, and should be using the
>> _fw functions.
> 
> Problem is, ~nobody knows when they should be using _fw anymore when
> they're all over the place. It'll get cargo culted.

It's not too hard, IMO.

Called from vblank evasion:
All functions should use the _dsb postfixed functions if applicable, and intel_de_read_fw.
On code only for old platforms, the _fw functions can be used.

Lockdep complains hard on PREEMPT_RT if this is not the case, especially since vblank
evasion with this series  doesn't acquire or release any lock at all. It will allow us
to uncouple the VBLANK_EVASION_TIME_US define from PROVE_LOCKING.

Should I switch to use the _dsb prefixes all the time for readability?

Called from vblank readout:
- we're disabling preemption, so _fw functions must be used as the spinlocks cannot be taken.

Other cases:
- Normal functions. Same for encoder enabling etc.

Sidenote:
I believe it's a mistake to make the intel_dmc_wl_get/put() functions implicit. There
is already power well support for everything that needs it.

Explicit force_wake like xe_force_wake would be a better model. It could be implemented as
simple as holding the dmc forcewake around the entire modeset sequence, which would still
be protective. While for debugging we can still complain about affected registers outside
the sequence until CI is clean.

Kind regards,
~Maarten Lankhorst
