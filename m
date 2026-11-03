Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.105.120.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704889;
	b=ZSCt5FeME1TmZXMOgyFnzIUN8aVWgcfqNVzs9kLdMztOHeoIqhM94BGh3T86yv3kPqM7
	 i6yOzdWXPYaxiWJat6VewDYJxvIhg4npsMqWY7zYoiHwC88nuTgpW1zHPv9B/BoBp96fN
	 OY318hBHg50X5CvujOt/QNpI2bFFIDM4SEJJp1UgJn737Yyt5fSH3ky4TpMc7ambo3KAj
	 daqDB42cdpf868kS0Ow5wu+hX1e0VCW9vLyxEbuSPORkX1mf4BWJ4TeSYCB6+oXZplSDv
	 m9wkNMXfCxabT8nQBI5vCXTrEuk91Xe4eJESgeyKlfSZqEMaRB+2yBhWGCc37YQRSMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704889;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vX0qXEOYp/vWA4lRL1YKkRKb9n812WRGoB/BC583hWU=;
	b=qdnKupJNYRpwidrkJ+kh8hTQxQ8iCaNTBD9nY1KmN+huUSsqoZwTc8lzhpGPLFpn1lbO
	 BrrrnnzmEM6i/n5JtWhfqHkFiv6Pfw28zEk2nvlaWNVqxsmkmFozYEPS5Ol5BHAuqw7F2
	 HsuiDWYjHINaQ216fYIcLQqqSsfEr2Uehlraocvvz9kc1Z2mWwcJwZxbD5Z76ISf4JZdu
	 guNCxmbHcjmFP4MLmkKt7+4KptHyBwVYXEQXbUZF2iUA0NfS9SEk+xf/ufieKt6i0BMof
	 CucgzjMBlhv/m37mhUmrGHNLyFKRCg+FVXeqJswgtAIhlKInuLLz64Pt+qUsDELlM7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lankhorst.se;
	spf=pass smtp.mailfrom=lankhorst.se;
	dkim=pass header.d=lankhorst.se header.i=@lankhorst.se header.a=rsa-sha256 header.s=default header.b=jd2xHX5Z;
	arc=none smtp.remote-ip=141.105.120.124
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E94606A80D
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 11:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E94606A80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.a=rsa-sha256 header.s=default header.b=jd2xHX5Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1793704886;
	bh=WsecBn/49e7uFyfqCo1gbvGorAO+WAvATYilIhVU0do=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=jd2xHX5ZE2f2SxpSjFFacchwNbUt1xmsp9KsjBIabSum0Nn0NalBpOZd/WdLcp5+f
	 AkqXC4N/LDODtoiDbvHJByML9slvFytsVc5uXdeG1gocaUTPshjsG+OERyEnp5mqwL
	 6M/EhvOB06Gy2ruu9Ub86GuBd2MU7mv8orIAygxNR7Q0vaiAszZrzfz6Zkhfgt2Jfh
	 olYslm687tgXuk2dwbqnWlX1U5/VUewQrxy+3ZqpWVjUevuI9RzzuUJOZYlD5RHtfs
	 kvWCR+cxMPIj4lb3t2VX9oXXdSzpSQxMangaMJwf2iEjc+nlzQ51AkpQezboYhRHvI
	 zIE0JP9atqCwA==
Message-ID: <ec59fe20-1e22-4009-89b9-af5b3d37fcee@lankhorst.se>
Date: Tue, 3 Nov 2026 12:22:22 +0100
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/xe/gsc: warn about GSC stolen memory usage on RT
 kernels
To: Junxiao Chang <junxiao.chang@intel.com>, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, airlied@gmail.com, simona@ffwll.ch,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20261104032732.30681-1-junxiao.chang@intel.com>
 <20261104032732.30681-3-junxiao.chang@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20261104032732.30681-3-junxiao.chang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

On 11/4/26 04:27, Junxiao Chang wrote:
> The GSC microcontroller requires stolen memory, which can introduce
> latency spikes and negatively impact real-time performance.
> 
> Print a warning on CONFIG_PREEMPT_RT kernels to inform the user that GSC
> is active and that RT performance can be improved by disabling the GSC
> firmware (e.g., by setting the module parameter xe.gsc_firmware_path="").
> 
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_gsc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_gsc.c b/drivers/gpu/drm/xe/xe_gsc.c
> index aab59dc647fbd..3d06ab6fecbe0 100644
> --- a/drivers/gpu/drm/xe/xe_gsc.c
> +++ b/drivers/gpu/drm/xe/xe_gsc.c
> @@ -427,6 +427,11 @@ int xe_gsc_init(struct xe_gsc *gsc)
>  	else if (ret)
>  		goto out;
>  
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		xe_gt_warn(gt, "RT performance might be impacted by GSC stolen memory usage\n");
> +		xe_gt_warn(gt, "Consider disabling GSC (xe.gsc_firmware_path=\"\") to improve it\n");
> +	}
Is this a problem on discrete as well, or only on integrated?

Kind regards,
~Maarten Lankhorst> +
>  	ret = xe_gsc_proxy_init(gsc);
>  	if (ret && ret != -ENODEV)
>  		goto out;

