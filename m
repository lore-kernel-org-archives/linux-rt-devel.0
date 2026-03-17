Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928D35773F
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Mar 2026 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791230; cv=pass; b=t0MD/CtLqGWXIQTXp5O9O95wNoLCdZdOd8mU9gbLrmZRCM3feMDLP+sppBGz6nswapXd6ikj5rLVMqWY7U/NMrr/eAxiHzFem9iL/WaZTQp3mxan1nNGPFDChjOG9nVvrXxTWFEZkMrRd73QBmeuJFjV1R2VvXcp/mHCfhyUUDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791230; c=relaxed/simple;
	bh=7FEO+WO9gtmeaYRXFXZeU+isk6gKICBV5TmJ0jQgtTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqKswcAJrQMMJK7LYwCqsi9vFOp18eoQ8fiGUObV8T/KTJduhSIJwt5+d4gQQ1wsqt8a7JY+D8Dcejg87cDDhT1E2f6lSot33mUVanJ81KQ2joeIv1pCVUgzi5qC0ElLGFBV1/VZRHB1B9P6XFHviLtLy3q0/tXOn7MZOrzw6+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTMCQp1Z; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTMCQp1Z"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad9238d8fso335378d50.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 17 Mar 2026 16:47:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773791228; cv=none;
        d=google.com; s=arc-20240605;
        b=cHnQazSTnGN9yhCGomwDIdiq7yrReOOXQl8wEvOucV6caeId9pZYPeDriYx0DuDsG1
         4qAiQkXYKEwiLqXCRKJxGGiKxWwfv8Ie9NMRxVHh2V3fb5Az9geIUGYGsgaEGSlH1/+N
         tL7ROdQQCwv3pqT1FOQ+C767q9YvNGWZEBe/+kV7mAMnJeDNweXMhL8YmdNn0cwj+Dqx
         PPmRQ5FmuPj6gSe7KQDgCnzVtd5EzO/eGJoBTVrZCX0f2ZIW4Gfzttiefu8AO5TvO/bK
         FjLX+QDxaR3MdmH1n2eZmkponp1C4FN4fQJjjH8bGd+1WQ1NEbrq1ncOc+2YcgHS+btg
         jDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TYnQ9K1Z99UlbHr7eq/pZE+TksjxYKszUFpuakhmm1s=;
        fh=4Tul37Mh+hggXiTSZ512YkiLtN5vQOIGZ4sk03YCzlk=;
        b=QNEphvrXcsyM+Pla9kpqhx0V5Nees+uAGg2hGgjEbP3ShJFPKiA69HYfG1NwlGEqkj
         CVE4r22D4a2/HxW3WGKL7BsJ/5Rl+qtC3In85pEM7dP5OMEGyh2iYCNTuBvJdS5AlMA+
         Wp6EVRjMpVAVEfSMu42vA0IGQ/WkNz7IG/814B+WiPRHtspwXDSmzgYgVm61IDZeyaMq
         TjOHtvTeLVqC7w2CUF5s32a65Mkcqo/T+z+Mijnx8DjTQ0uWyrN4yTva46+EFFXY7QU7
         TpSAnfY+Rxfh5Bd3LqtriTFIk+DZDGOI8PTBOxpy9rLqzC5bpc2uHAQaL7ruINCEkiSA
         Q5UQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773791228; x=1774396028; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYnQ9K1Z99UlbHr7eq/pZE+TksjxYKszUFpuakhmm1s=;
        b=aTMCQp1ZY5VFuRinYQeDVY6oaV12oQodTqAhmF5h67BrYCxD0440QJ8Mw0guAglsvD
         ZANErniD6VnK0plUX0AebJjNWoyCVBHApCrKrPWpgyFMCQl0yWhyyS7OY+uJMaEVodBS
         njaIDDurh+19523Su/4PqxyEz3sk6RlkNguDnuQiIjVgggCPxr7DB44isRFGAI2Izl8j
         cJn7bLy8cRqFhs9vFnD87q0rR9KJ0XZiRYiFzPR4PPh3PyT1Aig/I9CcbCJEKTSzoPun
         40xF9XUzcefr08iTX+SKGBXX0g/oziHgMBkhC8PmDgEdbqSTO8YcmwPAgUKe8SpQktNi
         SpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773791228; x=1774396028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TYnQ9K1Z99UlbHr7eq/pZE+TksjxYKszUFpuakhmm1s=;
        b=pv6fJ94Far1ai5wLifiTL5U0k4t/Il4lkWDcuR4lRPzRWKQRGc1mB4wzNvnKIx61hW
         dWSQiV5c/ZYZNuSP2/EXV6zUFfP2HKLknEsCiLi5qx1QC64VZhwTcRzegk7zmnFk4x/h
         ghfjIRC67JPXqgLmnhAHSQS0dTn12Uux60OnU+CENUUWSN3yioilLwaKcP14XsIUNHSE
         UKkoqAzIZdl92sA2EcIcqL993AOmdnCid83JSQJoprvNDtJ5QTC354Mq47GWz7vHky+J
         grOoQ4I+Saa1Wnt3qAvTupcTTBC0GRqNkCOq163/ui9HTKwaagk2HOYTlS7HxrFBap34
         k4qw==
X-Forwarded-Encrypted: i=1; AJvYcCWR7464QU3r+73MZy611EKY8ItVje0VXKBL4K2i1niEMO52i1ObgUXJgNzGQ7RdDbctwJ+E0p/dmVfiji1Lxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGvSC8cYYbCfJt4b/BD+8gm8g+azgItGmYwzMM1rFoFUO7XiSL
	yce2aSm0/lqtwj8bAIQPLtzYrnfA5dyLwGcxCARS65YXxbazas7PDNnYWLNC5o0Rjpb/GsSUrL+
	oxZ5llvM6jRHUQrz29wJ98SB9blCjQl9Nd+qQzeRX
X-Gm-Gg: ATEYQzz7coUcD8Uh/tZmJQlp2ohepvL53FQ6cNM8psseb2xEJZr4y7M2v8vE9mq07vB
	2nEvLw4aOxhc3ntHIN7/0vq/5oZQvncjv9395kFDfmkuuE0tha0VUyhsbx/l4GstaFgL67SoIyK
	BcKRSAQug7mACS7nAq+ishWEi0Z38yAwOZGjNRmzwYvrrMMWGuluKPWmtNGM/yZtq2dq/S3X8Jn
	Z+AQofSQRUnopkH3iBxQQ57RSyijYr7ADFsTjTJVjgQNyaL4+l6mv0en+tOVysuEhACWKAimTha
	u16JRtnPt+XIbMqziirm1T8+yxAP+l3JOZg=
X-Received: by 2002:a05:690e:4492:b0:64c:9fcf:2ad6 with SMTP id
 956f58d0204a3-64e91735a9fmr1320814d50.74.1773791227342; Tue, 17 Mar 2026
 16:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260316232819.6872-1-emil.s.tantilov@intel.com> <20260316232819.6872-2-emil.s.tantilov@intel.com>
In-Reply-To: <20260316232819.6872-2-emil.s.tantilov@intel.com>
From: Li Li <boolli@google.com>
Date: Tue, 17 Mar 2026 16:46:55 -0700
X-Gm-Features: AaiRm53EgQN0srwPUlGkyxpZzqDPqm7JMjWgqbwuCg88u6Jwx7G7TAITi-bhaOM
Message-ID: <CAODvEq6xHtbtaV_8D0yxWMrBxNryocoB2fvXfvrN-N47FmPZMw@mail.gmail.com>
Subject: Re: [PATCH iwl-net 1/3] idpf: improve locking around idpf_vc_xn_push_free()
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, 
	linux-rt-devel@lists.linux.dev, sgzhang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As discussed in the previous email, I had an minor & optional comment:

Personally, I think the code would read better if we just get rid of
the push_free state and use 2 separate code paths:

release_and_unlock:
idpf_vc_xn_release_bufs(xn);
idpf_vc_xn_unlock(xn);
idpf_vc_xn_push_free(&adapter->vcxn_mngr, xn);
return retval;

only_unlock:
idpf_vc_xn_unlock(xn);
return retval;

But I don't have strong opinions whether or not the suggestion above
is taken, and the patch LGTM.

Thank you Emil!

Reviewed-by: Li Li <boolli@google.com>



On Mon, Mar 16, 2026 at 4:28=E2=80=AFPM Emil Tantilov <emil.s.tantilov@inte=
l.com> wrote:
>
> Refactor the VC logic dealing with transaction accounting where
> both push and pop_free are using the same spinlock free_xn_bm.
> This resolves potential race when setting and clearing the bits
> in the free_xn_bm bitmask.
>
> Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
> Reported-by: Ray Zhang <sgzhang@google.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index 113ecfc16dd7..21a6c9d22085 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -401,12 +401,18 @@ struct idpf_vc_xn *idpf_vc_xn_pop_free(struct idpf_=
vc_xn_manager *vcxn_mngr)
>   * idpf_vc_xn_push_free - Push a free transaction to free list
>   * @vcxn_mngr: transaction manager to push to
>   * @xn: transaction to push
> + *
> + * Callers must ensure idpf_vc_xn_release_bufs() has been called (under
> + * idpf_vc_xn_lock) before invoking this function. This function must
> + * be called without holding idpf_vc_xn_lock to avoid nesting a sleepabl=
e
> + * spinlock inside a raw_spinlock on PREEMPT_RT kernels.
>   */
>  static void idpf_vc_xn_push_free(struct idpf_vc_xn_manager *vcxn_mngr,
>                                  struct idpf_vc_xn *xn)
>  {
> -       idpf_vc_xn_release_bufs(xn);
> +       spin_lock_bh(&vcxn_mngr->xn_bm_lock);
>         set_bit(xn->idx, vcxn_mngr->free_xn_bm);
> +       spin_unlock_bh(&vcxn_mngr->xn_bm_lock);
>  }
>
>  /**
> @@ -428,6 +434,7 @@ ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
>                         const struct idpf_vc_xn_params *params)
>  {
>         const struct kvec *send_buf =3D &params->send_buf;
> +       bool push_free =3D false;
>         struct idpf_vc_xn *xn;
>         ssize_t retval;
>         u16 cookie;
> @@ -514,10 +521,13 @@ ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapte=
r,
>         }
>
>  release_and_unlock:
> -       idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
> +       idpf_vc_xn_release_bufs(xn);
> +       push_free =3D true;
>         /* If we receive a VC reply after here, it will be dropped. */
>  only_unlock:
>         idpf_vc_xn_unlock(xn);
> +       if (push_free)
> +               idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
>
>         return retval;
>  }
> @@ -559,7 +569,7 @@ idpf_vc_xn_forward_async(struct idpf_adapter *adapter=
, struct idpf_vc_xn *xn,
>         }
>
>  release_bufs:
> -       idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
> +       idpf_vc_xn_release_bufs(xn);
>
>         return err;
>  }
> @@ -619,6 +629,7 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter=
,
>         case IDPF_VC_XN_ASYNC:
>                 err =3D idpf_vc_xn_forward_async(adapter, xn, ctlq_msg);
>                 idpf_vc_xn_unlock(xn);
> +               idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
>                 return err;
>         default:
>                 dev_err_ratelimited(&adapter->pdev->dev, "Overwriting VC =
reply (op %d)\n",
> --
> 2.37.3
>
