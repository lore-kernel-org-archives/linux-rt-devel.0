Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7067970830
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Mar 2026 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792836; cv=pass; b=uaYk4p7i5dlzBJ4OEN09TvajkZBjqTFu9QCzEnJoC6L/97DMPHx9m0fjxPtqgkob2QjvKz+71XPrMHHY+JVI6Xas71tV8Bd3Dv4YonnqMXVDP2CyVHkry51HdapnuPACAPsXmRNWaG1vi+6guHrp6xxAT9quEv836DIse2D1uMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792836; c=relaxed/simple;
	bh=1dlBnp6Q0uDDUW6pxd7bhUV/OtX8ZFdk+vReX36VBAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1MmylI2MXubVRw+ssD+DETvJbURLWM2c35agva9yXpRDSPC5KYq95sugutbV3pli47gM+IIpn+06Wb4WXB27AuzXKQMcwe8Kiz3JETPZMESnCRhj5jMwQpBMT7zrxn2sCY4tTZ176g8gCsD7FGlk6497k4ObjWbSXha4bpvr1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XLRlhbHl; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLRlhbHl"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64e8c7f5082so1339680d50.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 17 Mar 2026 17:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773792834; cv=none;
        d=google.com; s=arc-20240605;
        b=CWoZIeFMEpVcQoqYmrLQy5ZIm60xS1viHPUJxyQUysLvY+lhj5/oBvFY/e2JOcWWLQ
         aAky1W04lxxaBbDINcgpdQ+jgd5ByEiBLsCxUAGgkU8VRScR52YUMm1YZu1OT1xNyZgY
         vZoPcRtJfEuRxYy8WTDlThSMHiPKfAIuOaVBpmA9Fv2fA0uxK7y366AfrhpRiafyuNSo
         5YnHWzYAm28FjCBSKtcyCKOsE0D9b8mNfPuMMZLqhMdrjBNW6Oo1B5g1V1BBJkzVNCCb
         0YoG2Hs7K+p5jLElnAYlfD+Rdj0rD+ziiNjEyBFlizYQm5yK5o0xXFJNJkR1clXTMeg8
         n5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NH3lKMbPGzMjHktQ2S0JYx2HKd1BHzthwHWo0yjIxC8=;
        fh=8aESFRNiH8pILYQ0m9dl/8eF8kaAQh1VBH/Fkjl8GeA=;
        b=B3mECaj0YQLlh/3Wj+60YjC6qeSzGKu2EDXdrJYqXjc9aQLxZ3UAfIHfOlSgFL3ITZ
         DrlWS7i1298bVt+OEQ2RUj3fCigdPzyZNyKy+z+FLq2WvVFswxZxJ3/xMPcfd4lx4uZ6
         mleCXOMs9bWmIHHpMa37y4n8HNypCGAMB/BjW+zeb2bduGA7t9CWLGpCHUIs+xdsYw7k
         O2InL0UhJtKUEulfLYX8npXd6Kg9TPukoVEWA/TaIQpngIrjgnyBnel2l/BkPrA/gSIa
         VV/0T1d4hP9OwZw9LrrbiUGdOMsAVDfc7zm4kwMJ6bz6QqKD0SnLJ3XCycC9dQX60qlL
         VaVg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773792834; x=1774397634; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH3lKMbPGzMjHktQ2S0JYx2HKd1BHzthwHWo0yjIxC8=;
        b=XLRlhbHlniaVWpkFL4aPCSeRf8pjInSqjW+7HUiYezStXkOci+73AneykTdgbwls4L
         kWpUZzABBxtCFv8h8lgQ8eAFUvV0BDeIPSXALU+ULn2FHTUmANmJm7Qpyy0tIJeQIH2t
         UAvVN2adknT2pOUcDBwJ5VvBbVFJ2nO5mmLB1PuyOU4FgjZjYjC82qdkg6JyrIUB4aqp
         Tw9z/CjE3rxAnFdOpBgIIilb6mBDrsuxr5M/zUB87eiuD8mj8yvubpJ1Ydl2IVI1SaCx
         89spJIDs9RGj/9bISI1lH6grZnl2VbZ4jZSqKIg6X5dHgdM5Rm30fodZSdSN6eNPbLiZ
         Ql0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773792834; x=1774397634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NH3lKMbPGzMjHktQ2S0JYx2HKd1BHzthwHWo0yjIxC8=;
        b=nAyaZkuzV+cFGOlVFinfkNnd22Nu63edo5VICoUu0ko/vjMTrC2WFrQN9cCP0eT8uJ
         NlMhgAUFjXGldNU8/xS86SROmMvWMI0XKC2tax6eJH9J0cvoTRvfiKPhZMfPBYvNpsTM
         NshBywltbCOj2tSWIiCPSEwd3Zn6iSkrTIvOP8pqIpkUJfSsxJNDU8phGiWS98YELK7G
         rXiJvcrm4dHJCTgzCWrxWj9Z20ef1mxBBypcOP+q4pQd9chxQaKTa5F71yLpOOfnA9eE
         NMQjCpf8JP/pBBJINH1P0OCcz/NHKEsAIFgcWD74xUuHAz+tB73n59IJdhA69tzgzLAn
         lOvg==
X-Forwarded-Encrypted: i=1; AJvYcCWD/PSrMXu5SzuWcEvNpHcs4xV4tBhfsP1ue40UNcvdIJJk4elccF4zuOrOgshjM8WMcpsQwb8GaLvA5uoW6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfXq4J2iyp+xqno13dxNiM4unkqAKGBjGPSXLxow94sJRv05+h
	rF7kK/pb5X5jfpZhgRQxRxA+orR9o1z/qT0VKKXgavpFfpb3W3jzfudT5S66xg39BYSgAVvlqz9
	sVJNPCe+EjXl0aeFEWgjfBpBc1UALpJeK6kQSnhXT
X-Gm-Gg: ATEYQzxkDiDg/hpdI0pdST71nErRuZ0Hy7VxmjCszkkuB38EneVuPUCTIY8lCeY5CpK
	Q/dL4rid05oEb1qKsaitvdKpPz2dnncFzVmM9rEq/PlvnTxg/g21+ml/dDv+M28C0P6UK7cqWVB
	K5AxysvK566fIPdUvk7xXXwIlwToleE+FvAKbd5PSmAgmEAh9qHgntdLpPr4OJTSO7SQCA2llEi
	fO7qkYd+85tfbMLwO28e4GAS4POXHoKfoqkcXokwSivTYeDTLjSsXz5+TyyVko+KaHbheT5n7hO
	cvuDD4++M0fx0Y40LUPHqzr1pSwyvV0UpDc=
X-Received: by 2002:a53:acdb:0:20b0:64c:9ee9:7784 with SMTP id
 956f58d0204a3-64e912ea4edmr1596743d50.11.1773792834005; Tue, 17 Mar 2026
 17:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260316232819.6872-1-emil.s.tantilov@intel.com> <20260316232819.6872-4-emil.s.tantilov@intel.com>
In-Reply-To: <20260316232819.6872-4-emil.s.tantilov@intel.com>
From: Li Li <boolli@google.com>
Date: Tue, 17 Mar 2026 17:13:41 -0700
X-Gm-Features: AaiRm52502HuPWZDlNe1pVsboDjRd5-YbjXG_qFrypIUllH3EkzzS3xrhNFe7OA
Message-ID: <CAODvEq6ZDoAxzZ4scKtE7tnfe94wBwgTsckEfLzwxFo=BcLNSA@mail.gmail.com>
Subject: Re: [PATCH iwl-net 3/3] idpf: fix PREEMPT_RT raw/bh spinlock nesting
 for async VC handling
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, 
	linux-rt-devel@lists.linux.dev, sgzhang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

Reviewed-by: Li Li <boolli@google.com>

On Mon, Mar 16, 2026 at 4:28=E2=80=AFPM Emil Tantilov <emil.s.tantilov@inte=
l.com> wrote:
>
> Restructure the ASYNC case to allow calling idpf_vc_xn_forward_reply()
> outside of idpf_vc_xn_lock(). This avoids invalid wait context reported b=
y
> the kernel due to the async handler taking BH spinlock:
>
> [  805.726977] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  805.726991] [ BUG: Invalid wait context ]
> [  805.727006] 7.0.0-rc2-net-devq-031026+ #28 Tainted: G S         OE
> [  805.727026] -----------------------------
> [  805.727038] kworker/u261:0/572 is trying to lock:
> [  805.727051] ff190da6a8dbb6a0 (&vport_config->mac_filter_list_lock){+..=
.}-{3:3}, at: idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
> [  805.727099] other info that might help us debug this:
> [  805.727111] context-{5:5}
> [  805.727119] 3 locks held by kworker/u261:0/572:
> [  805.727132]  #0: ff190da6db3e6148 ((wq_completion)idpf-0000:83:00.0-mb=
x){+.+.}-{0:0}, at: process_one_work+0x4b5/0x730
> [  805.727163]  #1: ff3c6f0a6131fe50 ((work_completion)(&(&adapter->mbx_t=
ask)->work)){+.+.}-{0:0}, at: process_one_work+0x1e5/0x730
> [  805.727191]  #2: ff190da765190020 (&x->wait#34){+.+.}-{2:2}, at: idpf_=
recv_mb_msg+0xc8/0x710 [idpf]
> [  805.727218] stack backtrace:
> ...
> [  805.727238] Workqueue: idpf-0000:83:00.0-mbx idpf_mbx_task [idpf]
> [  805.727247] Call Trace:
> [  805.727249]  <TASK>
> [  805.727251]  dump_stack_lvl+0x77/0xb0
> [  805.727259]  __lock_acquire+0xb3b/0x2290
> [  805.727268]  ? __irq_work_queue_local+0x59/0x130
> [  805.727275]  lock_acquire+0xc6/0x2f0
> [  805.727277]  ? idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
> [  805.727284]  ? _printk+0x5b/0x80
> [  805.727290]  _raw_spin_lock_bh+0x38/0x50
> [  805.727298]  ? idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
> [  805.727303]  idpf_mac_filter_async_handler+0xe9/0x260 [idpf]
> [  805.727310]  idpf_recv_mb_msg+0x1c8/0x710 [idpf]
> [  805.727317]  process_one_work+0x226/0x730
> [  805.727322]  worker_thread+0x19e/0x340
> [  805.727325]  ? __pfx_worker_thread+0x10/0x10
> [  805.727328]  kthread+0xf4/0x130
> [  805.727333]  ? __pfx_kthread+0x10/0x10
> [  805.727336]  ret_from_fork+0x32c/0x410
> [  805.727345]  ? __pfx_kthread+0x10/0x10
> [  805.727347]  ret_from_fork_asm+0x1a/0x30
> [  805.727354]  </TASK>
>
> Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
> Reported-by: Ray Zhang <sgzhang@google.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 21 +++++++------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index 6b9692b30040..8ceabd86e172 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -546,32 +546,24 @@ static int
>  idpf_vc_xn_forward_async(struct idpf_adapter *adapter, struct idpf_vc_xn=
 *xn,
>                          const struct idpf_ctlq_msg *ctlq_msg)
>  {
> -       int err =3D 0;
> -
>         if (ctlq_msg->cookie.mbx.chnl_opcode !=3D xn->vc_op) {
>                 dev_err_ratelimited(&adapter->pdev->dev, "Async message o=
pcode does not match transaction opcode (msg: %d) (xn: %d)\n",
>                                     ctlq_msg->cookie.mbx.chnl_opcode, xn-=
>vc_op);
>                 xn->reply_sz =3D 0;
> -               err =3D -EINVAL;
> -               goto release_bufs;
> +               return -EINVAL;
>         }
>
> -       if (xn->async_handler) {
> -               err =3D xn->async_handler(adapter, xn, ctlq_msg);
> -               goto release_bufs;
> -       }
> +       if (xn->async_handler)
> +               return xn->async_handler(adapter, xn, ctlq_msg);
>
>         if (ctlq_msg->cookie.mbx.chnl_retval) {
>                 xn->reply_sz =3D 0;
>                 dev_err_ratelimited(&adapter->pdev->dev, "Async message f=
ailure (op %d)\n",
>                                     ctlq_msg->cookie.mbx.chnl_opcode);
> -               err =3D -EINVAL;
> +               return -EINVAL;
>         }
>
> -release_bufs:
> -       idpf_vc_xn_release_bufs(xn);
> -
> -       return err;
> +       return 0;
>  }
>
>  /**
> @@ -631,7 +623,10 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapte=
r,
>                  * can evaluate the response.
>                  */
>                 xn->reply_sz =3D ctlq_msg->data_len;
> +               idpf_vc_xn_unlock(xn);
>                 err =3D idpf_vc_xn_forward_async(adapter, xn, ctlq_msg);
> +               idpf_vc_xn_lock(xn);
> +               idpf_vc_xn_release_bufs(xn);
>                 idpf_vc_xn_unlock(xn);
>                 idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
>                 return err;
> --
> 2.37.3
>
