﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.3607
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Allegiance.CommunitySecuritySystem.TagTestClient.CssServer.Tag {
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="CssServer.Tag.ITag")]
    public interface ITag {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/ITag/SaveGameData", ReplyAction="http://tempuri.org/ITag/SaveGameDataResponse")]
        int SaveGameData(out string message, string gameData);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    public interface ITagChannel : Allegiance.CommunitySecuritySystem.TagTestClient.CssServer.Tag.ITag, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "3.0.0.0")]
    public partial class TagClient : System.ServiceModel.ClientBase<Allegiance.CommunitySecuritySystem.TagTestClient.CssServer.Tag.ITag>, Allegiance.CommunitySecuritySystem.TagTestClient.CssServer.Tag.ITag {
        
        public TagClient() {
        }
        
        public TagClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public TagClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public TagClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public TagClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public int SaveGameData(out string message, string gameData) {
            return base.Channel.SaveGameData(out message, gameData);
        }
    }
}
