Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C133443ABC
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193320; cv=none; b=GNJOArRZt5M4FyoqhJ364+ypV8Ovz6IKzXAXbRD0qoxJAUgPBzZu85NGJBFqqJDSYPPJXHpfW0eLC7iSrjbNutWmMxRXeGEf9UEZWQ9hLnmxSWztGaAaK0gTNGW+FPBPEnFB8qGaa2v02I/2EnLt5pLnnGQHDl4hcY2JZA6MEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193320; c=relaxed/simple;
	bh=4wASPUEGd3KOv6Fdubi246q8cZj4P8D3ytyUATn9DWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzeKlILS1baX62OzD3bGbogU2ptRGfNe59Dsm+35+oyu4Vn3CSQ49G7xzIlse1bbEWc73OkLTegqrBDDUFuhC6qqrIuPCdZKPJ/TBoP4TGlf3aYsOAy121g/Tq4ei857RkLGOItvLk8RniVnM1Sy4t+y6aCc/ANNWx2F67+bHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8wqOq0X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8wqOq0X"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso1881548a91.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 09:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788193318; x=1788798118; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4wASPUEGd3KOv6Fdubi246q8cZj4P8D3ytyUATn9DWg=;
        b=k8wqOq0XUXx1LIaaLobwJsxcx/QZ2IiV693To6zT5voF2/i3SHOoaDGjaoC23Up1yx
         +9K4LnHtiJr0Z3Y20FAebzmAy/XQ50f/94NaUVT0XHAkLw45s+NS+3rQm2LRyh9VOcZ9
         BBYv99NbtvUOpH5tP0gePpPQrPMWzb8AdKU+6tU9Y6FSu6U1eiJovGOI8NY3MlXIieJp
         vF+xboSvB+SAHlW7SCRbXZuIlnnhu6BGNW1GmSQVC8ik2znnSIMdDdL5en78W3La5fqY
         lMlp5qW6Leub9tNzAlKm5gpkdX3MPCOEWhIFTIj/z3vSvHgvPiMYBUm069vO/qDTeqXN
         Hkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788193318; x=1788798118;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wASPUEGd3KOv6Fdubi246q8cZj4P8D3ytyUATn9DWg=;
        b=p1WQQh4oqG2epGhGil+QJsfq8RVvbU5ikbipY2IiomrIs/NLN5PylUzq3I76YL8XX9
         S3CpSXnecfI0l9/MZverHvO/rqp0aGgYgU15YaPwYbJCZRBnKd+TfDx9axWrquv1iXez
         2oB2cZbelGbr+Gyd0bmiUnLzWIZ08Yj1hmVkNhB+VV5v1LdjHWUDsfi1sLMR0iAsEMG+
         lGPGHyetviNizcmV6PBe6sYv+I+KAoh+sJ4PRi/D6888SD1Rj0Y0rxGAzRbQATvndeYp
         ISQjMmSX+h9hGb2zlupUWQRnQg92Dg4T8mSfeQMpGGAAn+47bMiT6E8S16b51S4rr4Gm
         xPrg==
X-Forwarded-Encrypted: i=1; AKwUvByLzU4RoQGKXywAqF8/hI/8VnyrKjFgNF6VNuvORtOtF+FDMzNc3mgu5+sg1I95yxl+sZ1kM+OCbwr36AlnoA==@lists.linux.dev
X-Gm-Message-State: AFuF++nrkvVeY9TWA57gJ/FArDww6d/sF8cR9AxNH2k7w55eD5B2Skcf
	YOUqB08ok/xBh8PW0BIKuNRBP7T96i95bfIx5Q5eI5Zlto3sHY2AjWib
X-Gm-Gg: AYBFou2gY6hsLLv+h0NrHYeUg5XSubKLi3uUteigVMAOzWIQ4m6rxOOnWI26GxfVLul
	BieBDxX96+yDFhKHAYLdxYR0DLCmj9g6FxfQXOs9DU30h1DxBNT4jfsqDmI5iaUTC0ETkFqP95X
	/e4zlCW/K3+DOAYSWIpT0T+eJRnrPrIBa1pcRgCNg2tIsVU0R44fHoqT/iYXgbzdsOGwHlQj4VP
	zAagjJKrNLI0JRv7Sav8IcNIPSw2HusGrJl1Fe05yNWfVPkGLQinonQ6raNz7gzADAIq1BwFg4f
	DTj4+vgDyjHkegrrhg5smIQZQOY96JojNvsMsaNbjHH+zRi+t9CR8niY3KJ/Wbv5m8yQMiCOGGO
	FHUHJ+l7hLVnaXFPy40yHntFfOlkdOJHTW6at+WbplV3FlOBAEG/VtykZAlxYliT7ECCuZz3srr
	52Iuu9vsvlkPJjmCxK/m8sft5r/8rj3lOHLt+fHWP8VTq8hWVBIscL5NU2nzknmoUiNrDp9AHaN
	fKcSGQ5mgC5u1Vm1vs=
X-Received: by 2002:a17:90b:50c6:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-396d1017316mr43646750a91.13.1788193318003;
        Mon, 31 Aug 2026 09:21:58 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:21dc:72d0:a033:17f7:ad44:4f35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1b395sm308743a91.1.2026.08.31.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:21:56 -0700 (PDT)
From: ThangNN99 <ngocthang2710.1999@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ThangNN99 <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH] mm/slab: don't use kfree_rcu_sheaf() on PREEMPT_RT again
Date: Mon, 31 Aug 2026 23:21:49 +0700
Message-ID: <20260831162149.8035-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
References: <20260831-b4-kfree_rcu_hotfix-v1-1-4f0fb882638b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks Vlastimil, this matches what I found and is functionally the
same fix I had in my v3. I built this exact logic (skip
kfree_rcu_sheaf() under CONFIG_PREEMPT_RT in kvfree_call_rcu(), same
dead-code removal in kfree_rcu_sheaf()) against commit 08dbfad3f504
with the syzbot .config and reproduced the original splat with
syzbot's C repro (writing "off" to
/sys/devices/system/cpu/smt/control to trigger the
__balance_push_cpu_stop -> select_fallback_rq ->
cpuset_cpus_allowed_fallback -> set_cpus_allowed_force ->
kvfree_call_rcu chain) — confirmed the exact same lockdep report as
syzbot, then rebuilt with the fix and confirmed the splat no longer
appears while the same code path still executes.

Feel free to add:

Tested-by: ThangNN99 <ngocthang2710.1999@gmail.com>

Thanks for picking this up and for the pi_lock/waitlock explanation,
that's a much more precise description than what I had.

ThangNN99
