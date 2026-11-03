Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.105.120.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702662;
	b=D27V9XGsQay32J9NP3vPj0zAF+iLwvnQ9MWxKA3fR9Pb+uQ6m82Oc4FEhbugY7WOP1e1
	 ETBVQvUBT/tji3SZSaH4uMZcMuJMVr0x6ooLw6p2O52C/MlqWySEjdZdiwhK9jj/s13Lk
	 BVUQylU0KBuhP7ogLJCkCLQOmCDek5r1XDFb5ufCi+hdrHjb0nMLr6HWhLzyR9xkY8u/I
	 8WcMy0QGt4PDjTAIO1wG7vIj3Vhk7erDAuXQCa0Yb8IL//LPclMyLBrfyq3hvAbhH0reX
	 EhMCXbNUL7/Bo6DcU9q4TnhRTnSUwbbrJetVdYVK2TKJ9GGglFxOcuv72Eop+zYyABQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702662;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ze6EOFcXEpU3d6Cb1v5A2+n80G7X0r1R6lw8zooxcg4=;
	b=MSLegRwLiR4py46ufA86uijUMLo2xt3S4Le2g09loUg10/3iCqEpmZvu3PBkwvZQ/bjt
	 6EIH+EC2Mdibms7brzJY3gpMre1ky7+VmraekjCPPTBtV0jHlt0hh6AI3LvgjPALqvWF1
	 SNk5XjPembRplnyMz1qHxc/953VtgN594jYov9JgCDR9x+o6CQ79UD0cD4Gx91p9GXdAZ
	 bQGKlHOK5DnY9lEc6A7HOIxYBnshzD2ar1LcoZQczsC6vaJYQIlqjDH6ivaHPZP/DTSA6
	 uX4AS2x/3vFEvQdFbi+FCUmXFJzIx69wJVVaG4L0EL/cAMI5WBf48pZ6Y8akeiqSskQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lankhorst.se;
	spf=pass smtp.mailfrom=lankhorst.se;
	dkim=pass header.d=lankhorst.se header.i=@lankhorst.se header.a=rsa-sha256 header.s=default header.b=lAvy7fRJ;
	arc=none smtp.remote-ip=141.105.120.124
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB1606F7FE
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 10:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61AB1606F7FE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.a=rsa-sha256 header.s=default header.b=lAvy7fRJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1793702652;
	bh=OpaMivqe7d52iZ6lcLVckz/GCFD53etTQkNAD34bc3Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=lAvy7fRJQZnPLS+Zr0eLEK2EhRjwIRQSLMqAuApIDK9LLU4oxAQCVFAnZcEApRmem
	 WEVMoGhKjBx1u6vahgm8LYOWb+UceXTsjW4YsEeQH+iTVNQYUFE0qG+WVCRjPkXhTM
	 EAyFhfcwsmsBYeXiTpWlLYjqSCGxKyp/DirExcAK1qM70CjHUA8lNWFR27ayHPU93L
	 4Gokx+rasSYRPQtITskOheVxbq1Jb881G0oIMmSb7dwc3Dgv8qdPLXxKEYmStqwi9T
	 SXKM4HEwTFt0EWRnYWcRjsU70u2kRR095CqTlQuW/8q0ObhGcam2Ft0nKgGskNWf6V
	 JLkzP8hw/4JkA==
Message-ID: <65fae402-e053-4a4f-ba55-6b5b51690eba@lankhorst.se>
Date: Tue, 3 Nov 2026 11:45:09 +0100
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
Subject: Re: [PATCH 1/2] drm/xe/display: Skip initial plane allocation from
 stolen memory on RT
To: Junxiao Chang <junxiao.chang@intel.com>, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, airlied@gmail.com, simona@ffwll.ch,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20261104032732.30681-1-junxiao.chang@intel.com>
 <20261104032732.30681-2-junxiao.chang@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20261104032732.30681-2-junxiao.chang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

Is a single performance hit during boot allowed?
If so, this is a better solution, as it helps on !PREEMPT_RT as well:

https://patchwork.freedesktop.org/series/170759/

The first patch in that series is a better solution than unconditionally disabling
stolen memory, as I from what I understand the problem only exists when media gt is enabled.

If not, we should probably unconditionally disable stolen framebuffer all the time.

But with the series, we preserve the initial framebuffer contents and ensure a smooth
handover, even without stolen.

The warning in 2/2 is probably fine.

Kind regards,
~Maarten Lankhorst

On 11/4/26 04:27, Junxiao Chang wrote:
> CPU access to stolen memory ranges can introduce latency spikes that
> compromise real-time (RT) guarantees on PREEMPT_RT kernels.
> 
> On PREEMPT_RT configurations, bypass retrieving the initial plane's
> framebuffer from stolen memory. This forces the driver to fall back to
> standard allocations, preventing RT latency degradation at the expense
> of seamless boot display takeover.
> 
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---
>  drivers/gpu/drm/xe/display/xe_initial_plane.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_initial_plane.c b/drivers/gpu/drm/xe/display/xe_initial_plane.c
> index 0f86b73036d03..fd0e2962412dd 100644
> --- a/drivers/gpu/drm/xe/display/xe_initial_plane.c
> +++ b/drivers/gpu/drm/xe/display/xe_initial_plane.c
> @@ -87,6 +87,12 @@ initial_plane_bo(struct xe_device *xe,
>  		struct ttm_resource_manager *stolen;
>  		u64 pte;
>  
> +		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +			drm_dbg_kms(&xe->drm,
> +				    "Skipping FB allocation from stolen mem due to PREEMPT_RT\n");
> +			return NULL;
> +		}
> +
>  		stolen = ttm_manager_type(&xe->ttm, XE_PL_STOLEN);
>  		if (!stolen) {
>  			drm_dbg_kms(&xe->drm, "No stolen for initial FB\n");

